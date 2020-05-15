library ieee;
use ieee.std_logic_1164.all;

entity traffic_light is
    port (
        clk, reset          : in std_logic;
        rc, yc, gc, rp, gp  : out std_logic;
        cd_time             : out integer;
    );
end traffic_light;

architecture Behavioral of traffic_light is

    type TrafficState is (
        redRed1, redGreen, redRed2, redYellowRed, greenRed, yellowRed
    );

    signal state_reg, next_state : TrafficState;
    signal time_left : integer range 0 to 10;

begin

end Behavioral ; -- Behavioral