-- ==============================================================
-- motor_control
-- Creation : 26/03/2016
-- Update : 26/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by : KHOYRATEE Farad
-- ==============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.constants.all;

ENTITY PWM IS
	PORT ( 
		clk							: in 	STD_LOGIC;
		reset						: in 	STD_Logic;
		
		--IN--
		encoder						: in 	std_logic;
		
		--OUT--
		data	 					: out 	std_logic_vector(31 downto 0);
		hv_control					: out 	std_logic;
		pwm							: out 	std_logic
		
		);
	END PWM;
	
ARCHITECTURE rtl OF PWM IS

-- PWM --
signal duty_cycle	: std_logic_vector(15 downto 0);

-- speed calcul --
signal speed		: integer;

Begin

PWM_entity : entity work.PWM
port map(
	clk			=> clk,
	reset		=> reset,
	duty_cycle	=> duty_cycle,
	pwm_out		=> pwm
);

speed_calcul_entity : entity work.speed_calcul
port map(
	clk			=> clk,
	reset		=> reset,
	encoder		=> encoder,
	speed		=> speed	
);

enslavement_entity : entity work.enslavement
port map(
	clk			=> clk,
	reset		=> reset,
	speed		=> speed,
	duty_cycle	=> duty_cycle
);

angular_position_entity : entity work.angular_position_control
port map(
	clk			=> clk,
	reset		=> reset,
	speed		=> speed,
	top			=> top,
	data		=> data
);

END rtl;