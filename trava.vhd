library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trava is
    generic (
        senha: natural range 0 to 255 := 150 ; -- NÃƒÆ’Ã‚Âºmero usado como senha para destravar
        tempo_para_desarme: natural range 0 to 255 := 40 -- Em segundos
    ) ;
    
    port (
        clock: in std_logic; -- Entrada de clock 1hz para contagem do tempo
        reset: in std_logic;
        input: in std_Logic_vector(7 downto 0) ; --Chaves para destravar
        segundos: out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
        trava1: out std_logic -- Sinal de led: 1 para travado, 0 para destravado 
    );
end entity;

architecture rtl of trava is

    type state_type is (travado, aberto) ;
    signal current_state : state_type := travado ;

    signal numeric_input : natural range 0 to 255 ;
    signal vetor_desarme : std_logic_vector(7 downto 0) ;
    signal contador : natural := tempo_para_desarme ;

begin

    process (clock, reset, input)
        
    begin
        numeric_input <= to_integer(unsigned(input)) ;
        
        vetor_desarme <= std_logic_vector(to_unsigned(contador, vetor_desarme'length)) ;

        if reset = '1' then
            current_state <= travado ;
            contador <= tempo_para_desarme;

        elsif (clock'event and clock = '1' and reset = '0') then
            case current_state is 
                when travado =>
						if (contador > 0) then
                    if numeric_input = senha then
                        trava1 <= '0' ;
                        segundos <= "11111111" ;
                        current_state <= aberto ;
                    else
                        trava1 <= '1' ;
                        segundos <= vetor_desarme ;
                        contador <= contador - 1 ;
                    end if ;
						  else
							segundos <= "00000000" ;
						end if ;
                when aberto =>
                    trava1 <= '0' ;
            end case ;
        end if ;
    end process;
end architecture;
