library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_binto7seg is
end entity;

architecture behavioral of tb_binto7seg is
    signal input : std_logic_vector(3 downto 0);
    signal display : std_logic_vector(7 downto 0);

    type tb is array (0 to 15) of std_logic_vector(7 downto 0);
    constant valores : tb := (
        "00000011", -- 0
        "10011111", -- 1
        "00100101", -- 2
        "00001101", -- 3
        "10011001", -- 4
        "01001001", -- 5
        "01000001", -- 6
        "00011111", -- 7
        "00000001", -- 8
        "00001001", -- 9
        "00010001", -- A
        "11000001", -- B
        "01100011", -- C
        "10000101", -- D
        "01100001", -- E
        "01110001"  -- F
    );

begin
    b1: entity work.binto7seg(rtl)
        port map(input => input, display => display);

    estimulo: process
    begin
        for i in 0 to 15 loop
            input <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns; 
            assert (display = valores(i))
                report "Erro na entrada: " & integer'image(i)
                severity failure;
        end loop;

        report "Fim do teste binto7seg" severity note;
        wait; 
    end process;
end architecture;