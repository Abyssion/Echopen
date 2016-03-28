-- ==============================================================
-- Constants
-- Creation : 30/01/2016
-- Update : 27/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
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

package constants is
	
	-- Common
	constant FCLK 				: integer 					:= 50;					-- MHz (unit)
	constant CLOCK_PERIOD 		: integer 					:= 1000 / FCLK;			-- ns  (unit)
	constant CLOCK_PERIOD_REAL	: sfixed(E downto -DEC) 	:= div(
																to_sfixed(1, E, -DEC),
																mult(
																	to_sfixed(FCLK, E, -DEC),
																	to_sfixed(1000, E, -DEC)
																	)
																);	-- s  (unit)
	-- PWM
	constant PWM_FREQUENCY 		: integer := 500;						-- kHz (unit)
	constant PWM_PERIOD			: integer := 1000000 / PWM_FREQUENCY;	-- ns  (unit)
	
	-- Speed Calcul
	constant COEF_REDUCER		: sfixed(E downto -DEC)	  	:= div(
																to_sfixed(173, E, -DEC),
																to_sfixed(9, E, -DEC)
																);
	constant POLE_NUMBER_SENSOR	: integer := 3;
	
	-- angular position calcul --
	constant DELTA_X			: sfixed(E downto -DEC)		:= div(
																to_sfixed(1, E, -DEC),
																to_sfixed(64, E, -DEC)																	
																);
	
	-- Enslavement
	constant SPEED_COMMAND		: sfixed(E downto -DEC) 	:= to_sfixed(75, E, -DEC); 						-- 10 tr/s (unit)
	
	-- RampGenerator
	constant TIME_RAMP			: integer := 100;						-- us (unit)
	constant MAX_VALUE_DAC		: integer := 2048;						-- Samples
	constant STEPS				: integer := MAX_VALUE_DAC / TIME_RAMP;
	constant STEPS_VECTOR		: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(STEPS, 16));

end constants;