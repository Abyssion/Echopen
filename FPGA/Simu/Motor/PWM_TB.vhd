-- ==============================================================
-- PWM Simulation
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

Entity PWM_TB is
End Entity;

Architecture Simu of PWM_TB is
	Component PWM is
		Port(
			clk							: IN STD_LOGIC;
			reset						: IN STD_Logic;
			
			--IN--
			duty_cycle					: IN STD_LOGIC_VECTOR(15 Downto 0);
			
			--OUT--
			pwm_out 					: OUT STD_LOGIC
		);
	end component;
	
	Signal t_clk 				: std_logic := '0';
	Signal t_reset 				: std_logic := '1';
	
	Signal t_duty_cycle			: std_logic_vector(15 Downto 0) := (15 Downto 0 => '0');
	
	Signal t_pwm_out			: std_logic := '0';
	
	Begin
	DUT : PWM
	Port map(
		clk 			=> t_clk,
		reset 			=> t_reset,
		duty_cycle 		=> t_duty_cycle,
		pwm_out 		=> t_pwm_out
	);
	
	Generate_clock : Process
	Begin
		wait for 20 ns;
			t_clk <= not t_clk;
	end process;
	
	Reset : Process
	Begin
		T_reset <= '0' after 5 us;
		wait;
	end process;

	Simulate_pwm : Process
	Begin
		wait for 20 us; 
		t_duty_cycle <= std_logic_vector(to_unsigned(50, 16));
		--t_clock_frequency <= std_logic_vector(to_unsigned(50000, 16));
		--t_pwm_frequency <= std_logic_vector(to_unsigned(100, 16));
		wait for 20 us; 
		t_duty_cycle <= std_logic_vector(to_unsigned(10, 16));
		wait for 20 us; 
		t_duty_cycle <= std_logic_vector(to_unsigned(80, 16));

	end process;
	
end simu;
	