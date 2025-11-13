library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is    
    port (
        clock: in std_logic; -- Entrada de clock 1hz para contagem do tempo
        reset: in std_logic;
        input: in std_Logic_vector(7 downto 0) ; --Chaves para destravar
        segundos: out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
        trava: out std_logic; -- Sinal de led: 1 para travado, 0 para destravado
        
        display : out std_logic_vector(7 downto 0) -- Leds do display de 7 seg 
    );
end entity;

architecture rtl of main is

    signal sec : std_logic_vector (7 downto 0);
    signal senha_binario : std_logic_vector (7 downto 0) ;
    signal high_4 : std_logic_vector (3 downto 0) ;
    signal low_4 : std_logic_vector (3 downto 0) ;
begin

    trava1 : entity work.trava(rtl)
        generic map (senha => 150, tempo_para_desarme => 30)
        port map (clock => clock, reset => reset, input => input, segundos => sec, trava => trava) ;

    senha_binario <= std_logic_vector(to_unsigned(150, senha_binario'length)) ;
    high_4 <= sec(7 downto 4) ;
    low_4 <= sec(3 downto 0) ;

    segundos <= sec ;


    display1 : entity work.binto7seg(rtl)
        port map (input => low_4, display => display) ;

    display2 : entity work.binto7seg(rtl)
        port map (input => high_4, display => display) ;

end architecture;