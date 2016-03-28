-- ==============================================================
-- motor enslavement using a constant speed as a reference
-- Creation : 01/02/2016
-- Update : 27/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by  : --
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

ENTITY enslavement IS
	PORT ( 
		clk							: in 	std_logic;
		reset						: in 	std_logic;
		
		--IN--
		speed						: in 	sfixed(E downto -DEC);
		
		--OUT--
		duty_cycle					: out 	std_logic_vector(15 Downto 0)
		
		);
	END enslavement;
	
ARCHITECTURE rtl OF enslavement IS

Signal static_error : sfixed(E downto -DEC) := to_sfixed(0, E, -DEC);

Begin

static_error <= SPEED_COMMAND - speed;

enslavement_process : Process(clk, reset)
	variable duty_cycle_temp : std_logic_vector(15 Downto 0) := std_logic_vector(to_unsigned(50,16));
Begin
	if reset = '1' then
		duty_cycle_temp := std_logic_vector(to_unsigned(50, 16));
	elsif rising_edge(clk) then
		if speed < SPEED_COMMAND then 
			duty_cycle_temp := duty_cycle_temp + 1;
		elsif speed > SPEED_COMMAND then
			duty_cycle_temp := duty_cycle_temp - 1;
		end if;
		duty_cycle <= duty_cycle_temp;
	end if;
end Process;

END rtl;