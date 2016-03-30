-- ==============================================================
-- pulse Simulation
-- Creation : 30/01/2016
-- Update : 30/01/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- ==============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_textio.all;
USE ieee.numeric_std.all;
USE std.textio.all;

Entity HighPulseVoltage_tb is
End Entity;

Architecture Simu of HighPulseVoltage_tb is
	Component HighPulseVoltage_Ctrl is
		Port(
			clk							: IN STD_LOGIC;
			reset						: IN STD_Logic;
			
			--IN--
			command						: IN STD_LOGIC;
			
			--OUT--
			High_Pulse_Voltage_Ctrl 	: OUT STD_LOGIC
		);
	end component;
	
	Signal t_clk 						: std_logic := '0';
	Signal t_reset 						: std_logic := '1';
	
	Signal t_command					: std_logic := '0';
	Signal t_High_Pulse_Voltage_Ctrl	: std_logic := '0';
	
	Begin
	DUT : HighPulseVoltage_Ctrl
	Port map(
		clk 			=> t_clk,
		reset 			=> t_reset,
		High_Pulse_Voltage_Ctrl => t_High_Pulse_Voltage_Ctrl,
		command 		=> t_command
	);
	
	Generate_clock : Process
	Begin
		wait for 20 ns;
			t_clk <= not t_clk;
	end process;
	
	Reset : Process
	Begin
		T_reset <= '0' after 250 us;
		wait;
	end process;

	Simulate_pulse : Process
	Begin
		wait for 250 ns; 
		t_command <= not t_command;
	end process;
	
end simu;
	