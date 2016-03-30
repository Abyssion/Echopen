-- ==============================================================
-- Constants
-- Creation : 30/01/2016
-- Update : 26/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

package operation is
	-- fixed point operation
	constant E 					: 	integer 	:= 31;
	constant DEC 				:	integer		:= 32;
	
	type fixed_point_tab is array(integer range <>) of sfixed(E downto -DEC);
	
	type UNRESOLVED_sfixed is array (INTEGER range <>) of STD_ULOGIC;
	
	-- Function --
	function add(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed;
	
	function sub(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed;
	
	function mult(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed;
	
	function div(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed;

end operation;

package body operation is
	
	function add(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed is
	begin
		return resize(a+b, a);
	end add;
	
	function sub(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed is
	begin
		return resize(a-b, a);
	end sub;
	
	function mult(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed is
	begin
		return resize(a*b,a);
	end mult;
	
	function div(
		a 		: sfixed(E downto -DEC);
		b 		: sfixed(E downto -DEC)
	) return sfixed is
	begin
		return resize(a/b,a);
	end div;

end operation;