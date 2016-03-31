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

package angular_position_pkg is

constant SHOOT_NUMBER	:	integer	:=	64;

type phi_array(0 to SHOOT_NUMBER-1) of sfixed(E downto -DEC);
type delta_array(0 to SHOOT_NUMBER-1) of sfixed(E downto -DEC);

function phi_calcul() return phi_array;
function delta_phi_calcul() return 

constant PHI		:=	phi_calcul();
constant DELTA_PHI	:=	delta_phi_calcul();
end angular_position_pkg;

package body angular_position_pkg is

function phi_calcul() is

	variable phi_temp : phi_array;
	
	for i in 0 to SHOOT_NUMBER-1 loop
		phi(i) := arcsin(((2*i)/(SHOOT_NUMBER-1))-1);
	end loop;
	
	return phi;
	
end phi_calcul;

function delta_phi_calcul() is

	variable delta_phi_temp : phi_array;
	
	for i in 1 to (SHOOT_NUMBER/2)-1 loop
		delta_phi_temp(i) := PHI((SHOOT_NUMBER/2)+i) - PHI((SHOOT_NUMBER/2)-i);
	end loop;
	
	for i in SHOOT_NUMBER/2 to SHOOT_NUMBER-1 loop
		delta_phi_temp(i) := PHI(SHOOT_NUMBER-i-1);
	end loop;
	
	delta_phi_temp(0)	:=	PHI(SHOOT_NUMBER/2);
	
	return delta_phi_temp;
	
end delta_phi_calcul;

end angular_position_pkg;