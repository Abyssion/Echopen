-- ==============================================================
-- High Pulse Voltage Control
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

ENTITY HighPulseVoltage_Ctrl IS
	PORT ( 
		clk							: IN STD_LOGIC;
		reset						: IN STD_Logic;
		
		--IN--
		command						: IN STD_LOGIC;
		
		--OUT--
		High_Pulse_Voltage_Ctrl 	: OUT STD_LOGIC
		
		);
	END HighPulseVoltage_Ctrl;
	
ARCHITECTURE rtl OF HighPulseVoltage_Ctrl IS

signal en_risingclk : std_logic;

type Pulse is (
		High_state,
		Low_State
	);
signal Single_pulse	: Pulse;

Begin

Pulse_generation : Process(clk, reset)
	begin
		if reset = '1' then
			High_Pulse_Voltage_Ctrl <= '0';
		elsif rising_edge(clk) then
			case Single_pulse is
				when High_state =>
					High_Pulse_Voltage_Ctrl <= '0';
					if command = '0' then
						High_Pulse_Voltage_Ctrl <= '0';
						Single_pulse <= Low_State;
					end if;
				when Low_State =>
					if command = '1' then
						High_Pulse_Voltage_Ctrl <= '1';
						Single_pulse <= High_State;
					end if;
			end case;
		end if;
	end process;

END rtl;