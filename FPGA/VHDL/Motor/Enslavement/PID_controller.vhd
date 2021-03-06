-- ==============================================================
-- PID controller
-- Creation : 27/03/2016
-- Update : 28/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by  : KHOYRATEE Farad
-- Approved by  : LICCIONI Vincent
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- packages -- 
use work.constants.all;
use work.operation.all;
use work.PID_constant.all;

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

ENTITY PID_controller IS
	PORT ( 
		clk							: in 	std_logic;
		reset						: in 	std_logic;
		
		--IN--
		static_error				: in 	sfixed(E downto -DEC);
		
		--OUT--
		command						: out 	sfixed(E downto -DEC)
		
		);
	END PID_controller;
	
ARCHITECTURE rtl OF PID_controller IS

signal proportional 	: 	sfixed(E downto -DEC);
signal integral 		: 	sfixed(E downto -DEC);
signal derivate 		: 	sfixed(E downto -DEC);
signal error_register 	:	fixed_point_tab(1 to N);
Begin

command <= sub(
				add(
					proportional,
					integral
				),
				derivate
			);

sampling_error : process(clk)
begin
	if rising_edge(clk) then
		error_register(2) <= static_error;
		error_register(1) <= error_register(2);
	end if;
end process;
			
proportional_calcul : process(clk)
begin
	if reset = '1' then
		proportional 	<= to_sfixed(0, E, -DEC);
	elsif rising_edge(clk) then
		proportional	<= mult(
							add(Kp, Kd),
							error_register(N)
							);
	end if;
end process;

integral_calcul :	process(clk)
	variable error_temp	: sfixed(E downto -DEC):= to_sfixed(0, E, -DEC);
begin
	if reset = '1' then
		integral 		<= to_sfixed(0, E, -DEC);
		error_temp		:= to_sfixed(0, E, -DEC);
	elsif rising_edge(clk) then
		error_temp := add(error_temp, error_register(N));
		integral 	<= mult(
							error_temp,
							Ki
						);
	end if;
end process;

derivative_calcul	: process(clk)
begin
	if reset = '1' then
		derivate	<=	to_sfixed(0, E, -DEC);
	elsif rising_edge(clk) then
		derivate	<=	mult(
							Kd,
							error_register(N-1)
						);
	end if;
end process;

END rtl;
