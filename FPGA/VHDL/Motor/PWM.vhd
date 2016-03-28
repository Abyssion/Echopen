-- ==============================================================
-- PWM generation
-- Creation : 30/01/2016
-- Update : 27/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by : KHOYRATEE Farad
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- packages -- 
use work.constants.all;

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

ENTITY PWM IS
	PORT ( 
		clk							: in STD_LOGIC;
		reset						: in STD_Logic;
		
		--IN--
		duty_cycle					: in STD_LOGIC_VECTOR(15 Downto 0); -- % (unit)
		
		--OUT--
		pwm_out 					: out STD_LOGIC
		
		);
	END PWM;
	
ARCHITECTURE rtl OF PWM IS

Signal T_on 			: integer;
Signal T_off			: integer;

Signal Tcounter_period	: std_logic_vector(15 downto 0);
Signal Tcounter_Ton		: std_logic_vector(15 downto 0);
Signal Tcounter_Toff	: std_logic_vector(15 downto 0);

signal pwm_temp			: std_logic;
type t_state is (
	T_high,
	T_low
);
Signal t_pwm : t_state;

Begin

pwm_generator : Process(clk, reset)
	begin
		if reset ='1' then
			Tcounter_Ton <= (Tcounter_Ton'range => '0');
			Tcounter_Toff <= (Tcounter_Toff'range => '0');
			pwm_out <= '0';
		elsif rising_edge(clk) then
			T_on 			<= (PWM_PERIOD/100) * to_integer(unsigned(duty_cycle));		-- ns (unit)
			T_off			<= PWM_PERIOD - T_on;										-- ns (unit)
			case t_pwm is
				when T_high =>
					if Tcounter_Ton+1 > std_logic_vector(to_unsigned((T_on/CLOCK_PERIOD),16)) then
						Tcounter_Ton <= (Tcounter_Ton'range => '0');
						t_pwm <= T_low;
					else
						pwm_out <= '1';
						Tcounter_Ton <= Tcounter_Ton + 1;
					end if;
				when T_low =>
					if Tcounter_Toff+1 > std_logic_vector(to_unsigned((T_off/CLOCK_PERIOD),16)) then
						Tcounter_Toff <= (Tcounter_Toff'range => '0');
						t_pwm <= T_high;
					else
						pwm_out <= '0';
						Tcounter_Toff <= Tcounter_Toff + 1;
					end if;
			end case;
			-- if (conv_integer(Tcounter_period)*CLOCK_PERIOD) > (PWM_PERIOD-1) then
				-- pwm_temp	<= not pwm_temp;
				-- Tcounter_period	<= (Tcounter_period'range => '0');
			-- else
				-- Tcounter_period <= Tcounter_period + 1;
			-- end if;
		end if;
	end Process;
END rtl;