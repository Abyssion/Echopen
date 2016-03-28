-- ==============================================================
-- mathematics function
-- Creation : 30/01/2016
-- Update : 30/01/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Tested by  : --
-- ==============================================================

library ieee;
use ieee.numeric_std.all;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;

package math_function is
	
	-- Math constants
	constant  E : REAL := 2.71828_18284_59045_23536;			-- Value of e
    constant  ONE_OVER_E : REAL := 0.36787_94411_71442_32160;	-- Value of 1/e
    constant  PI : REAL := 3.14159_26535_89793_23846;			-- Value of pi
    constant  TWO_PI : REAL := 6.28318_53071_79586_47693;		-- Value of 2*pi
    constant  ONE_OVER_PI : REAL := 0.31830_98861_83790_67154;	-- Value of 1/pi
    constant  PI_OVER_2 : REAL := 1.57079_63267_94896_61923;	-- Value of pi/2
    constant  PI_OVER_3 : REAL := 1.04719_75511_96597_74615;	-- Value of pi/3
    constant  PI_OVER_4 : REAL := 0.78539_81633_97448_30962;	-- Value of pi/4
    constant  THREE_PI_OVER_2 : REAL := 4.71238_89803_84689_85769;	-- Value 3*pi/2
    constant  LOG_OF_2 : REAL := 0.69314_71805_59945_30942;		-- Natural log of 2
    constant  LOG_OF_10 : REAL := 2.30258_50929_94045_68402;	-- Natural log of 10
    constant  LOG2_OF_E : REAL := 1.44269_50408_88963_4074;		-- Log base 2 of e
    constant  LOG10_OF_E: REAL := 0.43429_44819_03251_82765;	-- Log base 10 of e
    constant  SQRT_2: REAL := 1.41421_35623_73095_04880;		-- square root of 2
    constant  ONE_OVER_SQRT_2: REAL := 0.70710_67811_86547_52440;-- square root of 1/2
    constant  SQRT_PI: REAL := 1.77245_38509_05516_02730;		-- square root of pi
    constant  DEG_TO_RAD: REAL := 0.01745_32925_19943_29577;	-- Conversion factor from degree to radian
    constant  RAD_TO_DEG: REAL := 57.29577_95130_82320_87680;	-- Conversion factor from radian to degree
	
	function SIGN (X: real) return real is
	variable result : real;
	begin
		if X > 0.0 then
			result := 1.0;
		elsif X = 0.0 then
			result := 0.0;
		elsif X < 0.0 then
			result := -1.0;
		else
			result := -2.0;
		end if;
		return result;
	end SIGN;

	function CEIL (X : in real ) return INTEGER is
	variable result : INTEGER;
	begin
		result := X;
		return result;
	end CEIL;
	
	function FLOOR (X : in real ) return INTEGER is
	variable result : integer;
	begin
		result := X;
		return result;
	end FLOOR;
	
	function ROUND (X : in real ) return integer is
	constant Z : real := X / 1000;
	variable result : integer;
	begin
		if Z > 5000 then 
			result := CEIL(X);
		elsif Z < 5000 OR Z = 5000 then
			result := FLOOR(X);
		elsif X = 0.0 then
			result := 0;
		else
			result := 0;
		end if;
		return result;
	end ROUND;
	
	function REALMAX (X, Y : in REAL ) return REAL is
	variable result : real;
	begin
		if X > Y then
			result := X;
		elsif Y < X then
			result := Y;
		elsif X = Y then
			result := X;
		else
			result := 0.0;
		end if;
		return result;
	end REALMAX;
	
	function REALMIN (X, Y : in REAL ) return REAL is
	variable result : real;
	begin
		if X > Y then
			result := Y;
		elsif Y < X then
			result := X;
		elsif X = Y then
			result := X;
		else
			result := 0.0;
		end if;
		return result;
	end REALMIN;

	function SQRT (X : in REAL ) return REAL is
	constant Z : integer := X * 1000;
	variable result : real;
	begin
		FOR I in 0 to Z loop
			if Z < ((I * I) + 1) then
				result := I / 1000;
			end if;
		end loop;
		return result;
	end SQRT;
	
	function CBRT (X: in REAL) return REAL is
	constant Z : integer := X * 1000;
	variable result : real;
	begin
		For I in 0 to Z loop
			if Z < ((I * I * I) + 1) < 0 then
				result := I / 1000;
			end if;
		end loop;
		return result;
	end CBRT;
	
	function POWER (X: in INTEGER; Y : in REAL) return REAL is
	variable result : real := Y;
	begin
		For I in 0 to X loop
			result := result * Y;
		end loop;
		return result;
	end POWER;
	
	function EXP (X : in REAL) return REAL is
	variable result : real;
	begin
		result := X;
		return result;
	end EXP;
	--function INGEGRATE(Born_min : real, Born_max : real, 
	
	
	
end math_function;