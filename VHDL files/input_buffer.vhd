library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_buffer is
    Port ( clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         player1 : in STD_LOGIC;
         player2 : in STD_LOGIC;
         game_clk_in : in STD_LOGIC;
         p1Buf : out STD_LOGIC;
         p2Buf : out STD_LOGIC;
         reset_out : out STD_LOGIC);
end input_buffer;

architecture Behavioral of input_buffer is
    signal p1_sync1, p1_sync2, p1_prev : std_logic := '0';
    signal p2_sync1, p2_sync2, p2_prev : std_logic := '0';
    signal rst_sync1, rst_sync2 : std_logic := '0';
    signal p1_pressed, p2_pressed : std_logic := '0';
    signal game_clk_prev : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            p1_sync1 <= player1;
            p1_sync2 <= p1_sync1;
            p2_sync1 <= player2;
            p2_sync2 <= p2_sync1;
            rst_sync1 <= reset;
            rst_sync2 <= rst_sync1;
            p1_prev <= p1_sync2;
            p2_prev <= p2_sync2;
            game_clk_prev <= game_clk_in;
            if p1_sync2 = '1' and p1_prev = '0' then
                p1_pressed <= '1';
            elsif game_clk_in = '1' and game_clk_prev = '0' then
                p1_pressed <= '0';
            end if;
            if p2_sync2 = '1' and p2_prev = '0' then
                p2_pressed <= '1';
            elsif game_clk_in = '1' and game_clk_prev = '0' then
                p2_pressed <= '0';
            end if;
        end if;
    end process;

    p1Buf <= p1_pressed;
    p2Buf <= p2_pressed;
    reset_out <= rst_sync2;
end Behavioral;