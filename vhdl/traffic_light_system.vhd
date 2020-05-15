library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_system is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        display    : out std_logic_vector(6 downto 0);
        rc, yc, gc, rp, gp : out std_logic    
    );
end traffic_light_system;

architecture Structural of traffic_light_system is
	
	component traffic_light is
    port (
        clk, reset          : in std_logic;
        rc, yc, gc, rp, gp  : out std_logic;
        cd_time             : out integer
    );
	end component;
	
	component bcd_to_7seg is
		port(
			digit  	: in integer;
			display	: out std_logic_vector(6 downto 0)	 
		);
	end component;
	
	signal carry	: integer;
begin
	TLIGHT_I:	 traffic_light port map (clk, reset, rc=>rc,yc=>yc, gc=>gc, rp=>rp, gp=>gp, cd_time=>carry);
	BDC_7SEG_I:	 bcd_to_7seg port map(digit=>carry, display=>display); 

end Structural;