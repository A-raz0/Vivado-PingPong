----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2025 04:12:34 PM
-- Design Name: 
-- Module Name: ssd_pong - Behavioral
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
entity ssd_pong is
    Port ( data : in std_logic_vector(3 downto 0);
           seg : out std_logic_vector(6 downto 0));
end ssd_pong;
architecture Behavioral of ssd_pong is
begin
    with data select seg <=
        "0111111" when "0000",
        "0110000" when "0001",  
        "1011011" when "0010",  
        "1111001" when "0011", 
        "1110100" when "0100",  
        "1101101" when "0101", 
        "1101111" when "0110", 
        "0111000" when "0111", 
        "1111111" when "1000", 
        "1111101" when "1001", 
        "1111110" when "1010", 
        "1100111" when "1011", 
        "0001111" when "1100", 
        "1110011" when "1101", 
        "1001111" when "1110", 
        "1001110" when others; 
end Behavioral;
