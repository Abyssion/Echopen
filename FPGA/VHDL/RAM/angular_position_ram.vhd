-- ==============================================================
-- Vga ram
-- Creation : 22/03/2016
-- Update : 01/04/2016
-- Created by : KHOYRATEE Farad
-- Updated by : KHOYRATEE Farad
-- Simulated by : --
-- ==============================================================

-- standard library --
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-- packages -- 
use work.operation.all;
use work.angular_position_pkg.all;

-- fixe point --
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

entity angular_position_ram is 
generic(
  ADDRESS_SIZE      :   integer	:=	7;
  DATA_SIZE			:	integer	:=	64
);
port(
    -- In ---------------------------------------
    clk             :   in std_logic;
    write_enable    :   in std_logic;
    write_addr      :   in std_logic_vector(ADDRESS_SIZE-1 downto 0);
    read_addr       :   in std_logic_vector(ADDRESS_SIZE-1 downto 0);
    data_in         :   in std_logic_vector(DATA_SIZE-1 downto 0);

    -- Out --------------------------------------
    data_out        :   out std_logic_vector(ADDRESS_SIZE-1 downto 0)
    
);
end angular_position_ram;

architecture behavioral of angular_position_ram is

type ram is array(0 to (2**ADDRESS_SIZE)-1) of std_logic_vector(DATA_SIZE-1 downto 0);
signal angular_position_ram          : ram;

signal read_addr_sync   : std_logic_vector(ADDRESS_SIZE-1 downto 0);
begin

write_into_ram : process(clk)
begin
    if rising_edge(clk) then
        if write_enable = '1' then
            angular_position_ram(conv_integer(write_addr)) <= data_in;
        end if;
        read_addr_sync  <= read_addr;
    end if;
end process;

data_out <= angular_position_ram(conv_integer(read_addr_sync));

end behavioral;
