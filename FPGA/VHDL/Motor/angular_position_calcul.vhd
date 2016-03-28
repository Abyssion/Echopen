-- ==============================================================
-- angular position calcul
-- Creation : 30/01/2016
-- Update : 27/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by : --
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- packages -- 
use work.constants.all;
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
		
		--out--
		data						: out 	std_logic_vector(31 downto 0);
		top_echo					: out 	std_logic
		);
	END PWM;
	
ARCHITECTURE rtl OF PWM IS
	signal 	phi_register	:	fixed_point_tab(0 to 1);
	signal	phi				:	sfixed(E downto -DEC);
	signal	delta_phi		:	sfixed(E downto -DEC);
	signal 	delta_T			:	sfixed(E downto -DEC);
	signal 	position		:	integer range -64 to 64;
Begin

delta_phi_calcul : process(clk)
begin
	if reset='1' then
		delta_phi		<=	to_sfixed(0, E, -DEC);
		phi_register	<=	(0 to 1 => to_sfixed(0, E, -DEC));
	elsif rising_edge(clk) then
		phi_register(1)		<= 	phi;
		phi_register(0)		<= 	phi_register(1);
		delta_phi			<=	phi_register(1) - phi_register(0);
	end if;
end process;

delta_T_calcul : process(clk)
begin
	if reset='1' then
		delta_T		<=	to_sfixed(0, E, -DEC);
	elsif rising_edge(clk) then
		delta_T		<= 	div(delta_phi, speed);
	end if;
end process;

phi_calcul : process(clk)
begin
	if reset='1' then
		phi			<=	to_sfixed(0, E, -DEC);
	elsif rising_edge(clk) then
		phi			<= 	arcsin(
							mult(
								to_sfixed(position, E, -DEC),
								DELTA_X
							)
						);
	end if;
end process;

hv_top : process(clk)
begin
	if reset = '1' then
		top_echo	<=	'0';
	elsif rising_edge(clk) then
		top_echo	<= '1';
	end if;
end process;

end rtl;