library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_1hz is    
    port (
        clock_in: in std_logic;
		  clock_out: out std_logic
    );
end entity;

architecture rtl of clock_1hz is
begin

	process (clock_in)
		variable cont : natural := 0;
	begin
		if(clock_in'event and clock_in = '1') then
			cont := cont + 1;
			clock_out <= clock_in;
			if(cont = 50000000) then
				cont := 0;
				clock_out <= not clock_in ;
			
			end if;
		end if;
	end process ;
end architecture;
