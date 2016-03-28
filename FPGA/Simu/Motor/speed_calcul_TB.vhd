-- ==============================================================
-- speed_calcul Simulation
-- Creation : 26/03/2016
-- Update : 26/03/2016
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

Entity speed_calcul_TB is
End Entity;

Architecture Simu of speed_calcul_TB is
	Component speed_calcul is
		Port(
			clk							: in 	std_logic;
			reset						: in 	std_logic;
			
			--IN--
			encoder						: in 	std_logic;
			
			--OUT--
			speed	 					: out 	sfixed(E downto -DEC)
		);
	end component;
	
	Signal t_clk 				: std_logic := '0';
	Signal t_reset 				: std_logic := '1';
	Signal t_speed				: sfixed(E downto -DEC) := to_sfixed(0, E, -DEC);
	Signal t_encoder			: std_logic := '0';
	
	Begin
	DUT : speed_calcul
	Port map(
		clk 			=> t_clk,
		reset 			=> t_reset,
		encoder 		=> t_encoder,
		speed			=> t_speed
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
		wait for 250 us; 
		t_encoder <= '1';
		wait for 250 us;
		t_encoder <= '0';
		wait for 250 us; 
		t_encoder <= '1';
		wait for 250 us; 
		t_encoder <= '0';
		wait for 250 us; 
		t_encoder <= '1';
		wait for 250 us; 
		t_encoder <= '0';
		wait for 250 us;
		
		t_encoder <= '1';
		wait for 100 us;
		t_encoder <= '0';
		wait for 100 us; 
		t_encoder <= '1';
		wait for 100 us; 
		t_encoder <= '0';
		wait for 100 us; 
		t_encoder <= '1';
		wait for 100 us; 
		t_encoder <= '0';
		wait for 100 us; 
		
		t_encoder <= '1';
		wait for 50 us;
		t_encoder <= '0';
		wait for 50 us; 
		t_encoder <= '1';
		wait for 50 us; 
		t_encoder <= '0';
		wait for 50 us; 
		t_encoder <= '1';
		wait for 50 us; 
		t_encoder <= '0';
		wait for 50 us;
		
	end process;
	
end simu;
	