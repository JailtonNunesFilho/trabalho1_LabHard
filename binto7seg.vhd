library ieee;
use ieee.std_logic_1164.all;

entity binto7seg is
    port (
        input : in std_logic_vector(3 downto 0); --Valor binário a ser mostrado
        display : out std_logic_vector(7 downto 0) -- Leds do display de 7 seg
    );
end entity;

architecture rtl of binto7seg is

begin
	process (input)
	begin
		case input is
			when "0000" => -- 0
				display <= "00000011" ;
			when "0001" => -- 1
				display <= "10011111" ;
			when "0010" => -- 2
				display <= "00100101" ;
			when "0011" => -- 3
				display <= "00001101" ;
			when "0100" => -- 4
				display <= "10011001" ;
			when "0101" => -- 5
				display <= "01001001" ;
			when "0110" => -- 6
				display <= "01000001" ;
			when "0111" => -- 7
				display <= "00011111" ;
			when "1000" => -- 8
				display <= "00000001" ;
			when "1001" => -- 9
				display <= "00001001" ;
			when "1010" => -- A
				display <= "00010001" ;
			when "1011" => -- B
				display <= "11000001" ;
			when "1100" => -- C
				display <= "01100011" ;
			when "1101" => -- D
				display <= "10000101" ;
			when "1110" => -- E
				display <= "01100001" ;
			when "1111" => -- F
				display <= "01110001" ;
		end case ;
	end process;
end architecture;
