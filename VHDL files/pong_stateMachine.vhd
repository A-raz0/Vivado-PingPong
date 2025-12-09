----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 09:32:54 PM
-- Design Name: 
-- Module Name: pong_stateMachine - Behavioral
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

entity pong_stateMachine is
    Port ( clk : in std_logic;
         reset : in std_logic;
         p1_button : in std_logic;
         p2_button : in std_logic;
         game_active : in std_logic;
         state_out : out std_logic_vector(3 downto 0);
         led : out std_logic_vector(2 downto 0));
end pong_stateMachine;

architecture Behavioral of pong_stateMachine is
    signal current_state : std_logic_vector(3 downto 0) := "0000";
    signal current_led : std_logic_vector(2 downto 0) := "000";
begin
    led <= current_led;
    state_out <= current_state;

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= "0000";
            current_led <= "000";
        elsif rising_edge(clk) then
            if game_active = '1' then
                case current_state is
                    when "0000" =>
                        current_state <= "0001";
                        current_led <= "000";
                    when "0001" =>
                        if current_led = "110" then
                            current_state <= "0010";
                            current_led <= "111";
                        else
                            current_led <= std_logic_vector(unsigned(current_led) + 1);
                        end if;
                    when "0010" =>
                        if p2_button = '1' then
                            current_state <= "0011";
                            current_led <= "110";
                        else
                            current_state <= "0101";
                            current_led <= "000";
                        end if;
                    when "0011" =>
                        if current_led = "001" then
                            current_state <= "0100";
                            current_led <= "000";
                        else
                            current_led <= std_logic_vector(unsigned(current_led) - 1);
                        end if;
                    when "0100" =>
                        if p1_button = '1' then
                            current_state <= "0001";
                            current_led <= "001";
                        else
                            current_state <= "0110";
                            current_led <= "111";
                        end if;
                    when "0101" =>
                        current_state <= "0001";
                        current_led <= "001";
                    when "0110" =>
                        current_state <= "0011";
                        current_led <= "110";

                    when others =>
                        current_state <= "0000";
                        current_led <= "000";
                end case;
            end if;
        end if;
    end process;
end Behavioral;
