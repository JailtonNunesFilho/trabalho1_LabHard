library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is    
    port (
        clock: in std_logic; -- Entrada de clock 1hz para contagem do tempo
        reset: in std_logic;
        input: in std_Logic_vector(7 downto 0) ; --Chaves para destravar
        input_display: out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
        trava1: out std_logic; -- Sinal de led: 1 para travado, 0 para destravado
        
        display1 : out std_logic_vector(7 downto 0); -- Leds do display de 7 seg 
		  display2 : out std_logic_vector(7 downto 0) -- Leds do display de 7 seg 
    );
end entity;

architecture rtl of main is

    signal sec : std_logic_vector (7 downto 0);
    signal senha_binario : std_logic_vector (7 downto 0) ;
    signal high_4 : std_logic_vector (3 downto 0) ;
    signal low_4 : std_logic_vector (3 downto 0) ;
	 signal clock1 : std_logic ;
begin

	rego: entity work.clock_1hz(rtl)
		port map (clock_in => clock, clock_out => clock1) ;

    pix : entity work.trava(rtl)
        generic map (senha => 64, tempo_para_desarme => 30)
        port map (clock => clock1, reset => reset, input => input, segundos => sec, trava1 => trava1) ;

    senha_binario <= std_logic_vector(to_unsigned(150, senha_binario'length)) ;
    high_4 <= sec(7 downto 4) ;
    low_4 <= sec(3 downto 0) ;

    --segundos <= sec ;


    displayPIX1 : entity work.binto7seg(rtl)
        port map (input => low_4, display => display1) ;

    displayPIX2 : entity work.binto7seg(rtl)
        port map (input => high_4, display => display2) ;
		  
	input_display <= input ;

end architecture;
