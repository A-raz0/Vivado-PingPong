----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 09:32:54 PM
-- Design Name: 
-- Module Name: mux4bit - Behavioral
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

entity mux4bit is
    Port ( I0   : in  STD_LOGIC_VECTOR (3 downto 0);
           I1   : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC;
           Y   : out STD_LOGIC_VECTOR (3 downto 0));
end mux4bit;

architecture Behavioral of mux4bit is

begin
with sel select
    Y <= I0 when '0',
        I1 when '1',
        "0000" when others;

end Behavioral;