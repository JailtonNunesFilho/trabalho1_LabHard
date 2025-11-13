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

    --0
    display <= "11111100" when input = "0000" ;

    --1
    display <= "01100000" when input = "0001" ;

    --2
    display <= "11011010" when input = "0010" ;

    --3
    display <= "11110010" when input = "0011" ;

    --4
    display <= "01100110" when input = "0100" ;

    --5
    display <= "10110110" when input = "0101" ;

    --6
    display <= "10111110" when input = "0110" ;

    --7
    display <= "11100000" when input = "0111" ;

    --8
    display <= "11111110" when input = "1000" ;

    --9
    display <= "11110110" when input = "1001" ;

    --A
    display <= "11101110" when input = "1010" ;

    --B
    display <= "00111110" when input = "1011" ;

    --C
    display <= "10011100" when input = "1100" ;

    --D
    display <= "01111010" when input = "1101" ;

    --E
    display <= "10011110" when input = "1110" ;

    --F
    display <= "10001110" when input = "1111" ;

end architecture;