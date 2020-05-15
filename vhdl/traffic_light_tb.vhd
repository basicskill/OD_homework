library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_tb is
end entity traffic_light_tb;

architecture Test of traffic_light_tb is

    component traffic_light is
        port (
            clk, reset          : in std_logic;
            rc, yc, gc, rp, gp  : out std_logic;
            cd_time             : out integer
        );
    end component;

    constant C_CLK_PERIOD: time := 125 ms;

    signal clk : std_logic := '1';
    signal reset : std_logic;
    signal rc, yc, gc, rp, gp : std_logic;
    signal cd_time : integer;

begin

    LIGHT_i : traffic_light port map (clk, reset, rc, yc, gc, rp, gp, cd_time);

    clk <= not clk after C_CLK_PERIOD/2;

    STIMULUS : process
    begin
        reset <= '1';
        wait for C_CLK_PERIOD;
        reset <= '0';
        wait;
    end process ; -- STIMULUS

end Test ; -- Test