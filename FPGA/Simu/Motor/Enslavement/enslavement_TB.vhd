-- ==============================================================
-- enslavement Simulation
-- Creation : 26/03/2016
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

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

Entity enslavement_TB is
End Entity;

Architecture Simu of enslavement_TB is
	Component enslavement is
		Port(
			clk							: in 	std_logic;
			reset						: in 	std_logic;
			
			--IN--
			speed						: in 	sfixed(E downto -DEC);
			
			--OUT--
			duty_cycle					: out 	std_logic_vector(15 Downto 0)
		);
	end component;
	
	Signal t_clk 				: std_logic := '0';
	Signal t_reset 				: std_logic := '1';
	Signal t_speed				: sfixed(E downto -DEC) := to_sfixed(0, E, -DEC);
	Signal t_duty_cycle			: std_logic_vector(15 Downto 0);
	
	Begin
	DUT : enslavement
	Port map(
		clk 			=> t_clk,
		reset 			=> t_reset,
		speed			=> t_speed,
		duty_cycle		=> t_duty_cycle
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
		wait for 10 us;
		t_speed <= to_sfixed(60, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(65, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(70, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(75, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(80, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(85, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(90, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(85, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(80, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(75, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(70, E, -DEC);
		wait for 10 us;
		t_speed <= to_sfixed(65, E, -DEC);
	end process;
	
end simu;
	