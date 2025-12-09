----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 09:32:54 PM
-- Design Name: 
-- Module Name: clk1hz - Behavioral
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

entity clk1Hz is
    Port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk1Hz;

architecture Behavioral of clk1Hz is
    constant MAX_COUNT : integer := 50000000;
    signal count : integer range 0 to MAX_COUNT := 0;
    signal clk_temp : std_logic := '0';
begin
    process(clk_in, reset)
    begin
        if reset = '1' then
            count <= 0;
            clk_temp <= '0';
        elsif rising_edge(clk_in) then
            if count = MAX_COUNT - 1 then
                count <= 0;
                clk_temp <= not clk_temp;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    clk_out <= clk_temp;
end Behavioral;