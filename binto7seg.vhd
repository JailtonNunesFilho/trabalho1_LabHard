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

    

end architecture;