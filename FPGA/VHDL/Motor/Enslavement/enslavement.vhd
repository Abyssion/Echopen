-- ==============================================================
-- motor enslavement using a constant speed as a reference
-- Creation : 01/02/2016
-- Update : 28/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by  : --
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- packages -- 
use work.constants.all;
use work.operation.all;

-- fixed point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

ENTITY enslavement IS
	PORT ( 
		clk							: in 	std_logic;
		reset						: in 	std_logic;
		
		--IN--
		speed						: in 	sfixed(E downto -DEC);
		
		--OUT--
		duty_cycle					: out 	std_logic_vector(15 Downto 0)
		
		);
	END enslavement;
	
ARCHITECTURE rtl OF enslavement IS

Signal 	static_error 	: sfixed(E downto -DEC);
Signal	command			: sfixed(E downto -DEC);

component PID_controller
	port(
		clk							: in 	std_logic;
		reset						: in 	std_logic;
		static_error				: in 	sfixed(E downto -DEC);
		command						: out 	sfixed(E downto -DEC)
		);
end component;

Begin

static_error <= sub(SPEED_COMMAND, speed);

PID_controller_component : PID_controller port map(
	clk				=>	clk,
	reset			=>	reset,
	static_error	=> 	static_error,
	command			=>	command
);

enslavement_process : Process(clk, reset)
	constant	duty_max	:	sfixed(E downto -DEC) 
									:= sub(to_sfixed(DUTY_CYCLE_MAX, E, -DEC),to_sfixed(1, E, -DEC));
	constant	duty_min	:	sfixed(E downto -DEC) 
									:= add(to_sfixed(DUTY_CYCLE_MAX, E, -DEC),to_sfixed(1, E, -DEC));
begin
	if reset='1' then
		duty_cycle	<=	std_logic_vector(to_unsigned(0, duty_cycle'length));
	elsif rising_edge(clk) then
		if command	>	duty_max then
			duty_cycle	<=	std_logic_vector(to_unsigned(DUTY_CYCLE_MAX, duty_cycle'length));
		elsif command	<	duty_min then
			duty_cycle	<= 	std_logic_vector(to_unsigned(DUTY_CYCLE_MIN, duty_cycle'length));
		else
			duty_cycle	<=	std_logic_vector(to_unsigned(to_integer(command), duty_cycle'length));
		end if;
	end if;
end process;

-- enslavement_process : Process(clk, reset)
	-- variable duty_cycle_temp : std_logic_vector(15 Downto 0) := std_logic_vector(to_unsigned(50,16));
-- Begin
	-- if reset = '1' then
		-- duty_cycle_temp := std_logic_vector(to_unsigned(50, 16));
	-- elsif rising_edge(clk) then
		-- if speed < SPEED_COMMAND then 
			-- duty_cycle_temp := duty_cycle_temp + 1;
		-- elsif speed > SPEED_COMMAND then
			-- duty_cycle_temp := duty_cycle_temp - 1;
		-- end if;
		-- duty_cycle <= duty_cycle_temp;
	-- end if;
-- end Process;

END rtl;