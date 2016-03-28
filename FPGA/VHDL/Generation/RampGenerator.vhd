-- ==============================================================
-- Ramp generator for tgc control
-- Creation : 30/01/2016
-- Update : 30/01/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by : KHOYRATEE Farad
-- ==============================================================

LIBRARY IEEE;
use ieee.numeric_std.all;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;

ENTITY RampGenerator IS
	PORT ( 
		clk							: IN STD_LOGIC;
		reset						: IN STD_Logic;
		
		--IN--
		command_ramp				: IN STD_LOGIC;
		
		--OUT--
		ramp_out					: OUT STD_LOGIC_VECTOR(15 downto 0)
		
		);
	END RampGenerator;
	
ARCHITECTURE rtl OF RampGenerator IS

signal counter_steps : std_logic_vector;

type ramp is (
		High_state,
		Low_State
	);
signal Single_ramp	: ramp;

Begin

Pulse_generation : Process(clk, reset)
	begin
		if reset = '1' then
			High_Pulse_Voltage_Ctrl <= '0';
		elsif rising_edge(clk) then
			case Single_ramp is
				when High_state =>
					if counter_steps+1 > steps_vector OR command_ramp = '0' then
						counter_steps <= (others <= '0');
						Single_ramp <= Low_State;
					else
						counter_steps <= counter_steps + 1;
						ramp_out <= counter_steps;
					end if;
				when Low_State =>
					if command_ramp = '1' then
						Single_ramp <= High_State;
					end if;
			end case;
		end if;
	end process;

END rtl;