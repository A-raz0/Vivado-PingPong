----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2025 09:21:29 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity pong_main is
    Port ( clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         player1 : in STD_LOGIC;
         player2 : in STD_LOGIC;
         sw : in STD_LOGIC;
         cat : out STD_LOGIC_VECTOR(1 downto 0);
         seg : out STD_LOGIC_VECTOR(6 downto 0);
         led : out STD_LOGIC_VECTOR(7 downto 0));
end pong_main;

architecture Behavioral of pong_main is
    -- Component declarations
    component pong_stateMachine is
        Port ( clk : in std_logic;
             reset : in std_logic;
             p1_button : in std_logic;
             p2_button : in std_logic;
             game_active : in std_logic;
             state_out : out std_logic_vector(3 downto 0);
             led : out std_logic_vector(2 downto 0));
    end component;

    component pong_led is
        Port ( led_array : in std_logic_vector(2 downto 0);
             led_go : out std_logic_vector(7 downto 0));
    end component;

    component ssd_dual is
        Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             data1 : in STD_LOGIC_VECTOR(3 downto 0);
             data2 : in STD_LOGIC_VECTOR(3 downto 0);
             winner : in STD_LOGIC_VECTOR(1 downto 0);
             cat : out STD_LOGIC_VECTOR(1 downto 0);
             seg : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    component clk_div is
        Port ( clk_in : in STD_LOGIC;
             reset : in STD_LOGIC;
             sw : in STD_LOGIC;
             clk_out : out STD_LOGIC);
    end component;

    component counter is
        Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             state : in STD_LOGIC_VECTOR(3 downto 0);
             output1 : out STD_LOGIC_VECTOR(3 downto 0);
             output2 : out STD_LOGIC_VECTOR(3 downto 0);
             winner : out STD_LOGIC_VECTOR(1 downto 0);
             game_active : out STD_LOGIC);
    end component;

    component input_buffer is
        Port ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             player1 : in STD_LOGIC;
             player2 : in STD_LOGIC;
             game_clk_in : in STD_LOGIC;
             p1Buf : out STD_LOGIC;
             p2Buf : out STD_LOGIC;
             reset_out : out STD_LOGIC);
    end component;

    signal game_clk : std_logic;
    signal current_state : std_logic_vector(3 downto 0);
    signal leds : std_logic_vector(2 downto 0);
    signal score1 : std_logic_vector(3 downto 0);
    signal score2 : std_logic_vector(3 downto 0);
    signal p1_buffered : std_logic;
    signal p2_buffered : std_logic;
    signal reset_buffered : std_logic;
    signal winner_signal : std_logic_vector(1 downto 0);
    signal game_running : std_logic;

begin
    divider : clk_div port map (
            clk_in => clk,
            reset => reset_buffered,
            sw => sw,
            clk_out => game_clk
        );

    input_buf : input_buffer port map (
            clk => clk,
            reset => reset,
            player1 => player1,
            player2 => player2,
            game_clk_in => game_clk,
            p1Buf => p1_buffered,
            p2Buf => p2_buffered,
            reset_out => reset_buffered
        );

    stateMachine : pong_stateMachine port map (
            clk => game_clk,
            reset => reset_buffered,
            p1_button => p1_buffered,
            p2_button => p2_buffered,
            game_active => game_running,
            state_out => current_state,
            led => leds
        );

    score_counter : counter port map (
            clk => game_clk,
            reset => reset_buffered,
            state => current_state,
            output1 => score1,
            output2 => score2,
            winner => winner_signal,
            game_active => game_running
        );

    ssd_display : ssd_dual port map (
            clk => clk,
            reset => reset_buffered,
            data1 => score1,
            data2 => score2,
            winner => winner_signal,
            cat => cat,
            seg => seg
        );

    led_disp : pong_led port map (
            led_array => leds,
            led_go => led
        );

end Behavioral;