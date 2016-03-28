-- ==============================================================
-- Echo sthetoscope :
--		* High Pulse Voltage Control
--		* TGC Control
--		* Enveloppe detector (Hilbert Transform)
--		* Servo motor
--		* ADC
--		* DAC
-- Creation : 30/01/2016
-- Update : 30/01/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by  : --
-- ==============================================================

LIBRARY IEEE;
use ieee.numeric_std.all;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;

ENTITY Top IS
	PORT ( 
		clk							: IN STD_LOGIC;
		reset						: IN STD_Logic;
		
		--IN--
		ADC							: IN STD_LOGIC_VECTOR(11 Downto 0);
		Motor_Position				: IN STD_LOGIC_VECTOR(11 Downto 0);
		Echo						: IN STD_LOGIC_VECTOR(11 Downto 0);
		
		--OUT--
		DAC							: OUT STD_LOGIC_VECTOR(11 Downto 0);
		High_Pulse_Voltage_Ctrl 	: OUT STD_LOGIC;
		TGC_Control					: OUT STD_LOGIC; -- Send a pulse or create a ramp using the DAC?
		PWM							: OUT STD_LOGIC_VECTOR(11 Downto 0);
		
		);
	END Top;
	
ARCHITECTURE rtl OF Top IS



END rtl;