library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_7seg_tb is
end bcd_to_7seg_tb;

architecture Test of bcd_to_7seg_tb is

	component bcd_to_7seg is
		port(
			digit  	: in integer;
			display	: out std_logic_vector(6 downto 0)	 
		);
	end component;
	
	signal digit	: integer := -1;
	signal display	: std_logic_vector(6 downto 0);
	
begin
	BCD_TO_7SEG_INST: bcd_to_7seg port map (digit, display);
	
	STIMULUS: process
	begin
		wait for 1 ns;
		digit <= 0;
		
		wait for 1 ns;
		digit <= 1;
		
		wait for 1 ns;
		digit <= 2;
		
		wait for 1 ns;
		digit <= 3;
		
		wait for 1 ns;
		digit <= 4;
		
		wait for 1 ns;
		digit <= 5;
		
		wait for 1 ns;
		digit <= 6;
		
		wait for 1 ns;
		digit <= 7;
		
		wait for 1 ns;
		digit <= 8;
		
		wait for 1 ns;
		digit <= 9;
		
		wait for 1 ns;
		digit <= 10;
		
		wait for 1 ns;
		digit <= 11;
		
		wait;
	end process STIMULUS;
	

end Test;