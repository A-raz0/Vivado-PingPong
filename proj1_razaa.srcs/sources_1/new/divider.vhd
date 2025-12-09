----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 09:32:54 PM
-- Design Name: 
-- Module Name: divider - Behavioral
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

entity clk_div is
    port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk_div;

architecture Behavioral of clk_div is

    component clk1Hz
        port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
    end component;
    
    component clk2Hz 
        port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
    end component;

    component mux2to1 
        port ( I0 : in STD_LOGIC;
           I1 : in STD_LOGIC;
           sel : in STD_LOGIC;
           Y : out STD_LOGIC);
    end component;
    
    signal clk_count_1Hz : std_logic;
    signal clk_count_2Hz : std_logic;
      
begin
    div_1 : clk1Hz port map(
        clk_in => clk_in,
        reset => reset,
        clk_out => clk_count_1Hz
    );

    div_2 : clk2Hz port map(
        clk_in => clk_in,
        reset => reset,
        clk_out => clk_count_2Hz
    );
    
    muxl : mux2to1 port map (
        I0 => clk_count_1Hz,
        I1 => clk_count_2Hz,
        sel => sw,
        Y => clk_out
    );
end Behavioral;
