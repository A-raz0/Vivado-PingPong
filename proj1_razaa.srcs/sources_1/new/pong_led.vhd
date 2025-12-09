----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 10:10:23 PM
-- Design Name: 
-- Module Name: pong_led - Behavioral
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

entity pong_led is
    Port ( led_array : in std_logic_vector(2 downto 0);
           led_go : out std_logic_vector(7 downto 0));
end pong_led;

architecture Behavioral of pong_led is
begin
 
    with led_array select led_go <=
        "10000000" when "000", 
        "01000000" when "001", 
        "00100000" when "010", 
        "00010000" when "011", 
        "00001000" when "100", 
        "00000100" when "101", 
        "00000010" when "110", 
        "00000001" when "111", 
        "00000000" when others;
end Behavioral;