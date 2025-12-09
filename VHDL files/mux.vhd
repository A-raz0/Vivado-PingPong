----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 09:32:54 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux2to1 is
    Port ( I0 : in std_logic;
           I1 : in std_logic;
           sel : in std_logic;
           Y : out std_logic);
end mux2to1;

architecture Behavioral of mux2to1 is
begin
    with sel select 
        Y <= I0 when '0',
             I1 when '1',
             '0' when others;
end Behavioral;
