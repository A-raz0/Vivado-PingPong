----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 10:10:23 PM
-- Design Name: 
-- Module Name: ssd_dual - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ssd_dual is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data1 : in STD_LOGIC_VECTOR(3 downto 0); -- P1 score
           data2 : in STD_LOGIC_VECTOR(3 downto 0); -- P2 score
           winner : in STD_LOGIC_VECTOR(1 downto 0); -- Winner indicator
           cat : out STD_LOGIC_VECTOR(1 downto 0);
           seg : out STD_LOGIC_VECTOR(6 downto 0));
end ssd_dual;

architecture Behavioral of ssd_dual is
    component clk60hz is
        Port ( clk_in : in STD_LOGIC;
               reset : in STD_LOGIC;
               clk_out : out STD_LOGIC);
    end component;
    
    component ssd_pong is
        Port ( data : in STD_LOGIC_VECTOR(3 downto 0);
               seg : out STD_LOGIC_VECTOR(6 downto 0));
    end component;
    
    component mux4bit is
        Port ( I0 : in STD_LOGIC_VECTOR(3 downto 0);
               I1 : in STD_LOGIC_VECTOR(3 downto 0);
               sel : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    signal refresh_clk : std_logic;
    signal digit_select : std_logic := '0';
    signal selected_data : std_logic_vector(3 downto 0);
    signal seg_decoded : std_logic_vector(6 downto 0);
    
    -- Flashing for winner (Extra Credit)
    signal flash_counter : integer range 0 to 50000000 := 0;
    signal flash_enable : std_logic := '1';
    
begin
    -- 60Hz clock for switching between digits
    clk60: clk60hz port map(
        clk_in => clk,
        reset => reset,
        clk_out => refresh_clk
    );
    
    -- Use 4-bit mux to select which score to display
    score_mux: mux4bit port map(
        I0 => data1,  -- Player 1 score
        I1 => data2,  -- Player 2 score
        sel => digit_select,
        Y => selected_data
    );
    
    -- SSD decoder
    decoder: ssd_pong port map(
        data => selected_data,
        seg => seg_decoded
    );
    
    -- Process to switch between digits
    process(refresh_clk, reset)
    begin
        if reset = '1' then
            digit_select <= '0';
        elsif rising_edge(refresh_clk) then
            digit_select <= not digit_select;
        end if;
    end process;
    
    -- Flash clock generator for winner (1Hz flash = slower, more visible)
    process(clk, reset)
    begin
        if reset = '1' then
            flash_counter <= 0;
            flash_enable <= '1';
        elsif rising_edge(clk) then
            if flash_counter = 25000000 - 1 then  -- Changed to 1Hz for better visibility
                flash_counter <= 0;
                flash_enable <= not flash_enable;
            else
                flash_counter <= flash_counter + 1;
            end if;
        end if;
    end process;
    
    -- Control which digit is on and flashing for winner
    process(digit_select, winner, flash_enable)
    begin
        if digit_select = '0' then
            -- Showing Player 1 score on left digit
            cat <= "01"; -- Left digit on
        else
            -- Showing Player 2 score on right digit
            cat <= "10"; -- Right digit on
        end if;
    end process;
    
    -- Separate process to handle segment blanking for flashing winner
    process(winner, flash_enable, seg_decoded, digit_select)
    begin
        if (winner = "01" and digit_select = '0' and flash_enable = '0') or
           (winner = "10" and digit_select = '1' and flash_enable = '0') then
            seg <= "0000000"; -- Blank the winning digit during flash-off
        else
            seg <= seg_decoded; -- Show normal segments
        end if;
    end process;
    
end Behavioral;