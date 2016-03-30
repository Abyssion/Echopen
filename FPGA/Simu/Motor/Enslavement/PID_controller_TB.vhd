-- ==============================================================
-- PID controller Simulation
-- Creation : 27/03/2016
-- Update : 28/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_textio.all;
USE ieee.numeric_std.all;
USE std.textio.all;

-- packages -- 
use work.constants.all;
use work.operation.all;
use work.PID_constant.all;

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

Entity PID_controller_TB is
End Entity;

Architecture Simu of PID_controller_TB is
	Component PID_controller is
		Port(
			clk							: in 	std_logic;
			reset						: in 	std_logic;
			
			--IN--
			static_error				: in 	sfixed(E downto -DEC);
			
			--OUT--
			command						: out 	sfixed(E downto -DEC)
		);
	end component;
	
	Signal t_clk 				: std_logic := '0';
	Signal t_reset 				: std_logic := '1';
	Signal t_static_error		: sfixed(E downto -DEC) := to_sfixed(0, E, -DEC);
	Signal t_command			: sfixed(E downto -DEC) := to_sfixed(0, E, -DEC);
	
	Begin
	DUT : PID_controller
	Port map(
		clk 			=> t_clk,
		reset 			=> t_reset,
		static_error	=> t_static_error,
		command			=> t_command
	);
	
	Generate_clock : Process
	Begin
		wait for 20 ns;
			t_clk <= not t_clk;
	end process;
	
	Reset : Process
	Begin
		T_reset <= '0' after 50 us;
		wait;
	end process;

	Simulate_encoder : Process
	Begin
		wait for 500 us;
		t_static_error <= to_sfixed(100, E, -DEC);
		wait for 500 us;
		t_static_error <= to_sfixed(0, E, -DEC);
		wait for 500 us;
		t_static_error <= to_sfixed(-100, E, -DEC);
	end process;
	
end simu;
	