----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 09:32:54 PM
-- Design Name: 
-- Module Name: clk60hz - Behavioral
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

entity clk60hz is
    Port ( clk_in  : in  STD_LOGIC;
         reset   : in  STD_LOGIC;
         clk_out : out STD_LOGIC );
end clk60hz;

architecture Behavioral of clk60hz is
    constant TOGGLE_COUNT : integer := 833333 - 1;
    signal temporal : std_logic := '0';
    signal counter  : integer range 0 to TOGGLE_COUNT := 0;
begin
    process(clk_in, reset)
    begin
        if reset='1' then
            counter <= 0; temporal <= '0';
        elsif rising_edge(clk_in) then
            if counter = TOGGLE_COUNT then
                counter <= 0; temporal <= not temporal;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    clk_out <= temporal;
end Behavioral;
