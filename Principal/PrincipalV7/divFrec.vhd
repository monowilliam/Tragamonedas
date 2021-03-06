library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divFrec is
port(
	clk : in std_logic;
	nclk : inout std_logic
);
end entity;
architecture divFrec_arc of divFrec is
shared variable count : integer :=0;
shared variable max_count : integer :=7000000;
begin
newclock:process (clk) is
			begin
				if rising_edge(clk) then 
					if count<max_count then
						count := count + 1;
					else
						count := 0;
						nclk <= not(nclk);
					end if;
				end if;
			end process;
end architecture;