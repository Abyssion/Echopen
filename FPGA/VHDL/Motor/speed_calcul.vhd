-- ==============================================================
-- Speed calcul from encoder
-- Creation : 01/02/2016
-- Update : 27/03/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by  : KHOYRATEE Farad
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- packages -- 
use work.constants.all;
use work.operation.all;

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

ENTITY speed_calcul IS
	PORT ( 
		clk							: IN STD_LOGIC;
		reset						: IN STD_Logic;
		
		--IN--
		encoder						: IN STD_LOGIC;
		
		--OUT--
		speed	 					: out	sfixed(E downto -DEC)
		
		);
	END speed_calcul;
	
ARCHITECTURE rtl OF speed_calcul IS

-- Pole counter --
Signal pulse_counter 		: std_logic_vector(15 downto 0);
Signal enable_reset_counter : std_logic;

-- Calculation --
Signal pulse_period_counter : std_logic_vector(15 downto 0);
Signal deltaT		 		: integer;

-- Edge detector --
Signal encoder_rising_edge 	: std_logic;
Signal encoder_falling_edge : std_logic;

type m_deltaT_state is (
	m_idle,
	m_deltaT_counter,
	m_reset
);
Signal m_deltaT : m_deltaT_state;

Begin

speed <= div(
			to_sfixed(1,E,-DEC),			
			mult(
				COEF_REDUCER,
				mult(
					div(
						to_sfixed(deltaT,E,-DEC),
						to_sfixed(1000,E,-DEC)
						),
					CLOCK_PERIOD_REAL
					)
				)
			);

edge_detector : process(clk)
	variable detect : std_logic_vector(1 downto 0);
begin
	if rising_edge(clk) then
		encoder_rising_edge 	<= '0';
		encoder_falling_edge 	<= '0';
		detect(1) 		:= detect(0);
		detect(0)		:= encoder;
		if detect="01" then
			encoder_rising_edge <= '1';
		elsif detect="10" then
			encoder_falling_edge <= '1';
		end if;
	end if;
end process;

pole_counter : Process(clk, reset)
begin
	if reset ='1' then
		pulse_counter 		 <= (pulse_counter'range => '0');
	elsif rising_edge(clk) then
		
		if encoder_rising_edge='1' then
			pulse_counter <= pulse_counter + 1;
		end if;
		
		if enable_reset_counter='1' then
			pulse_counter 		 <= (pulse_counter'range => '0')+1;
		end if;
	end if;
end Process;

calculation : process(clk)
begin
	if reset='1' then
		pulse_period_counter <= (pulse_period_counter'range => '0');
		deltaT		  		 <= 0;
		enable_reset_counter <= '0';
	elsif rising_edge(clk) then
		case m_deltaT is
			when m_idle =>
				enable_reset_counter <= '0';
				if encoder='1' then
					m_deltaT 	<= m_deltaT_counter;
				end if;
			when m_deltaT_counter =>
				pulse_period_counter <= pulse_period_counter + 1;
				if (conv_integer(pulse_counter) > POLE_NUMBER_SENSOR-1) and encoder_rising_edge='1' then
					deltaT 		<= conv_integer(pulse_period_counter)*2;
					m_deltaT	<= m_reset;
				end if;
			when m_reset =>
				enable_reset_counter <= '1';
				pulse_period_counter <= (pulse_period_counter'range => '0')+2;
				m_deltaT 			 <= m_idle;
		end case;
	end if;
end process;

END rtl;