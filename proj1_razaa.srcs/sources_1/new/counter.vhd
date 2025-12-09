----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2025 04:06:49 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           state : in STD_LOGIC_VECTOR(3 downto 0);
           output1 : out STD_LOGIC_VECTOR(3 downto 0);
           output2 : out STD_LOGIC_VECTOR(3 downto 0);
           winner : out STD_LOGIC_VECTOR(1 downto 0);
           game_active : out STD_LOGIC); -- adding to stop game after winner
end counter;

architecture Behavioral of counter is
    signal score1 : unsigned(3 downto 0) := "0000";
    signal score2 : unsigned(3 downto 0) := "0000";
    signal winner_reg : std_logic_vector(1 downto 0) := "00";
    signal game_running : std_logic := '1';
begin
    output1 <= std_logic_vector(score1);
    output2 <= std_logic_vector(score2);
    winner <= winner_reg;
    game_active <= game_running;
    
    process(clk, reset)
    begin
        if reset = '1' then
            score1 <= "0000";
            score2 <= "0000";
            winner_reg <= "00";
            game_running <= '1';
        elsif rising_edge(clk) then
            if game_running = '1' then
                case state is
                    when "0101" =>
                        if score1 = "1001" then
                            winner_reg <= "01";
                            game_running <= '0'; -- stops game if this doesnt work take out as was fine before
                        else
                            score1 <= score1 + 1;
                        end if;
                    when "0110" =>
                        if score2 = "1001" then
                            winner_reg <= "10";
                            game_running <= '0';
                        else
                            score2 <= score2 + 1;
                        end if;
                    
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;
end Behavioral;