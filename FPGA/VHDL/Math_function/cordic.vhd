library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity synth_cordic is port(
	clk		:	in	std_logic;
	reset	:	in	std_logic;
	X_ip	:	in	std_logic_vector(16 downto 0);
	Y_ip	:	in	std_logic_vector(16 downto 0);
	z_ip	:	in	std_logic_vector(16 downto 0);
	cos		:	out	std_logic_vector(16 downto 0);
	sin		:	out	std_logic_vector(16 downto 0)
);
end entity synth_cordic;

architecture rtl of synth_cordc is
	type signed_array is array(natural range <>) of signed(17 downto 0);
	
	-- ARCTAN array format 1,16 in radians
	constant tan_array	:	signed_aray(0 to 16)	:=	(
															to_signed(51471,18),
															to_signed(30385,18),
															to_signed(16054,18),
															to_signed(8149,18),
															to_signed(4090,18),
															to_signed(2047,18),
															to_signed(1023,18),
															to_signed(511,18),
															to_signed(255,18),
															to_signed(127,18),
															to_signed(63,18),
															to_signed(31,18),
															to_signed(15,18),
															to_signed(7,18),
															to_signed(3,18),
															to_signed(1,18),
															to_signed(0,18),
														);
	signal x_array		:	signed_array(0 to 14)	:=	(signed_array'range => (others => '0'));
	signal y_array		:	signed_array(0 to 14)	:=	(signed_array'range => (others => '0'));
	signal z_array		:	signed_array(0 to 14)	:=	(signed_array'range => (others => '0'));
begin

-- convert inputs into signed format
process(reset, clk)
begin
	if reset = '0' then
		x_array		<=	(others => (others => '0'));
		y_array		<=	(others => (others => '0'));
		z_array		<=	(others => (others => '0'));
	elsif rising_edge(clk) then
		if signed(z_ip) < to_signed(0,18) then
			x_array(x_array'low)		<=	signed(x_ip) + signed('0' & y_ip);
			y_array(y_array'low)		<=	signed(y_ip) - signed('0' & x_ip);
			z_array(z_array'low)		<=	signed(z_ip) + tan_array(0);		
		else
			x_array(x_array'low)		<=	signed(x_ip) - signed('0' & y_ip);
			y_array(x_array'low)		<=	signed(y_ip) + signed('0' & x_ip);
			z_array(x_array'low)		<=	signed(z_ip) - tan_array(0);		
		end if;
		for i in 1 to 14 loop
			if z_array(i-1) < to_signed(0,17) then
				x_array(i)				<=	x_array(i-1) + (y_array(i-1)/2**i);
				y_array(i)				<=	y_array(i-1) - (x_array(i-1)/2**i);
				z_array(i)				<=	z_array(i-1) + tan_array(i);				
			else
				x_array(i)				<=	x_array(i-1) + (y_array(i-1)/2**i);
				y_array(i)				<=	y_array(i-1) - (x_array(i-1)/2**i);
				z_array(i)				<=	z_array(i-1) + tan_array(i);	
			end if;
		end loop;
	end if;
end process;

cos	<=	std_logic_vector(x_array(x_array'high)(16 downto 0));
sin	<=	std_logic_vector(Y_array(Y_array'high)(16 downto 0));

end architecture rtl;
