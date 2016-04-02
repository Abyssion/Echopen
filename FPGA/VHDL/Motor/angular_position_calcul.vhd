-- ==============================================================
-- angular position calcul
-- Creation : 30/01/2016
-- Update : 27/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by : --
-- Info :
-- phi = arcsin(X) where X [-1;1] and phi [-pi/2;pi/2]
-- X has 128 values
-- delta_T = delta_phi/v 
-- where delta_T is the time between two top
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- packages -- 
use work.operation.all;

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

ENTITY PWM IS
	PORT ( 
		clk							: in 	std_logic;
		reset						: in 	std_logic;
		
		--in--
		speed						: in 	sfixed(E downto -DEC);
		delta_phi					: in 	sfixed(E downto -DEC);
		
		--out--
		data						: out 	std_logic_vector(31 downto 0);
		top_echo					: out 	std_logic
		);
	END PWM;
	
ARCHITECTURE rtl OF PWM IS

	signal 	delta_T			:	sfixed(E downto -DEC);
	
Begin

delta_T_calcul : process(clk)
begin
	if reset = '1' then
		delta_T	<=	to_sfixed(0, E, -DEC);
	elsif rising_edge(clk) then
		delta_T	<=	div(delta_phi, speed);
	end if;
end process;

hv_top : process(clk)
	variable counter :	integer	:=	0;
begin
	if reset = '1' then
		top_echo	<=	'0';
	elsif rising_edge(clk) then
		if counter > to_integer(delta_T)-1 then
			counter		<=	'0';
			top_echo	<= 	'1';
		else
			counter		<=	counter + 1;
			top_echo	<= 	'0';
		end if;
	end if;
end process;

end rtl;