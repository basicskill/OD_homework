library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_7seg is
	port(
		digit  	: in integer;
		display	: out std_logic_vector(6 downto 0)	 
	);
end bcd_to_7seg;


architecture Behavioral of bcd_to_7seg is
begin
	BCD_PROC: process(digit) is
	begin
		case(digit) is
			when 0=>
				display <= "0111111";
			when 1 =>
				display <= "0000110";
			when 2 =>
				display <= "1011011";
			when 3 =>
				display <= "1001111";
			when 4 =>
				display <= "1100110";
			when 5 =>
				display <= "1101101";
			when 6 =>
				display <= "1111101";
			when 7 =>
				display <= "0000111";
			when 8 =>
				display <= "1111111";
			when 9 =>
				display <= "1101111";
			when others =>
				display <= "0000000";
		end case;
	
	end process BCD_PROC;

end architecture Behavioral;