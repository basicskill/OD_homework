library ieee;
use ieee.std_logic_1164.all;

entity traffic_light is
    port (
        clk, reset          : in std_logic;
        rc, yc, gc, rp, gp  : out std_logic;
        cd_time             : out integer
    );
end traffic_light;

architecture Behavioral of traffic_light is

    type TrafficState is (
        redRed1, redGreen, redRed2, redYellowRed, greenRed, yellowRed
    );

    signal state_reg, next_state : TrafficState;
    signal time_left    : integer range 0 to 10;
    signal new_time     : integer range 0 to 10; 
    signal seconds_cnt  : integer range 0 to 7;

begin

    STATE_TRANSITION : process( clk )
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state_reg <= redRed1;   -- Reset state
                time_left <= 2;
                seconds_cnt <= 0;
            else
                if seconds_cnt = 7 then
                    seconds_cnt <= 0;
                    if time_left = 1 then
                        time_left <= new_time;
                        state_reg <= next_state;
                    else
                        time_left <= time_left - 1;
                    end if;
                else
                    seconds_cnt <= seconds_cnt + 1;
                end if;

            end if;
        end if;
    end process ; -- STATE_TRANSITION

    NEXT_STATE_LOGIC : process( state_reg, time_left )
    begin
        if time_left = 1 then
            case state_reg is

                when redGreen =>
                    next_state <= redRed2;
                    new_time <= 2;

                when redRed2 =>
                    next_state <= redYellowRed;
                    new_time <= 1;

                when redYellowRed =>
                    next_state <= greenRed;
                    new_time <= 9;

                when greenRed =>
                    next_state <= yellowRed;
                    new_time <= 1;
                
                when yellowRed =>
                    next_state <= redRed1;
                    new_time <= 2;
            
                when others =>  -- redRed1
                    next_state <= redGreen;
                    new_time <= 7;
            
            end case;
        else
            next_state <= state_reg;
        end if ; 
    end process ; -- NEXT_STATE_LOGIC

    LIGHT_LOGIC : process( state_reg )
    begin
        case state_reg is
            when redRed1 =>
                rc <= '1';
                yc <= '0';
                gc <= '0';
                rp <= '1';
                gp <= '0';

            when redGreen =>
                rc <= '1';
                yc <= '0';
                gc <= '0';
                rp <= '0';
                gp <= '1';
            
            when redRed2 =>
                rc <= '1';
                yc <= '0';
                gc <= '0';
                rp <= '1';
                gp <= '0';

            when redYellowRed =>
                rc <= '1';
                yc <= '1';
                gc <= '0';
                rp <= '1';
                gp <= '0';

            when greenRed =>
                rc <= '0';
                yc <= '0';
                gc <= '1';
                rp <= '1';
                gp <= '0';
                
            when yellowRed =>
                rc <= '0';
                yc <= '1';
                gc <= '0';
                rp <= '1';
                gp <= '0';

            when others =>
                rc <= '0';
                yc <= '0';
                gc <= '0';
                rp <= '0';
                gp <= '0';
            
        end case;

    end process ; -- LIGHT_LOGIC

    cd_time <=  time_left when state_reg = greenRed else
                10;

end Behavioral ; -- Behavioral