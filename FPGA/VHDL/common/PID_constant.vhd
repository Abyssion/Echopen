-- ==============================================================
-- PID Constants
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

package PID_constant is
	
	constant Ki	:	sfixed(E downto -DEC) 	:= 	to_sfixed(5.5, E, -DEC);
	constant Kp	:	sfixed(E downto -DEC) 	:= 	to_sfixed(300, E, -DEC);
	constant Kd	:	sfixed(E downto -DEC) 	:= 	to_sfixed(100, E, -DEC);
	
	constant N	:	integer					:=	2;

end PID_constant;