library ieee;
use ieee.std_logic_1164.all;

entity traffic_light is
    port (
        clk, reset          : in std_logic;
        rc, yc, gc, rp, gp  : out std_logic
        -- cd_time             : out integer;
    );
end traffic_light;

architecture Behavioral of traffic_light is

    type TrafficState is (
        redRed1, redGreen, redRed2, redYellowRed, greenRed, yellowRed
    );

    signal state_reg, next_state : TrafficState;
    signal time_left    : integer range 0 to 10;
    signal new_time     : integer range 0 to 10; 

begin

    STATE_TRANSITION : process( clk )
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state_reg <= redRed1;   -- Reset state
                time_left <= 4;
            else
                if time_left = 0 then
                    time_left <= new_time;
                else
                    time_left <= time_left - 1;
                end if;
                state_reg <= next_state;
            end if;
        end if;
    end process ; -- STATE_TRANSITION

    NEXT_STATE_LOGIC : process( state_reg, time_left )
    begin
        if time_left = 0 then -- PROVERI VREDNOST U SIMULATORU!
            case state_reg is
            
                when redRed1 =>
                    next_state <= redGreen; -- !!!
                    new_time <= 3; -- !!! Periodi clk vs Sekunde
                
                when redGreen =>
                    next_state <= redRed1; -- !!!
                    new_time <= 4;
            
                when others =>
                    next_state <= redRed1;
                    new_time <= 4;
            
            end case;
        else
            next_state <= state_reg;
        end if ; 
    end process ; -- NEXT_STATE_LOGIC

    OUTPUTLOGIC : process( state_reg )
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
            
            when others =>
                rc <= '1';
                yc <= '1';
                gc <= '1';
                rp <= '1';
                gp <= '1';
            
        end case;

    end process ; -- OUTPUTLOGIC

end Behavioral ; -- Behavioral