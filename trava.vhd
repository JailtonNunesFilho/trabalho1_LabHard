library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trava is
    generic (
        senha: natural range 0 to 255 ; -- Número usado como senha para destravar
        tempo_para_desarme: natural range 0 to 255 -- Em segundos
    ) ;
    
    port (
        clock: in std_logic; -- Entrada de clock 1hz para contagem do tempo
        reset: in std_logic;
        input: in std_Logic_vector(7 downto 0) ; --Chaves para destravar
        segundos: out std_logic_vector(7 downto 0); -- Tempo para desbloqueio
        trava: out std_logic -- Sinal de led: 1 para travado, 0 para destravado 
    );
end entity;

architecture rtl of trava is

    type state_type is (iniciado, travado, aberto) ;
    signal current_state, next_state : state_type ;
    signal numeric_input : natural range 0 to 255 ;
    signal vetor_contador : std_logic_vector(7 downto 0) ;
    signal contador : natural := 0 ;

begin
    process (clock, reset)
    begin
        if reset = '1' then
            current_state <= iniciado ;

        elsif (clock'event and clock = '1' and reset = '0') then

            if current_state = iniciado then
                current_state <= travado ;
            elsif next_state = aberto then
                current_state <= next_state ;
            end if ;

            contador <= contador - 1 ;
        end if ;
    end process;

    process (input, current_state)
    begin
        numeric_input <= to_integer(unsigned(input)) ;
        vetor_contador <= std_logic_vector(to_unsigned(contador, vetor_contador'length)) ;
        case current_state is
            when iniciado =>
                contador <= tempo_para_desarme ;
                trava <= '1' ;

            when travado =>
                if numeric_input = senha then
                    trava <= '0' ;
                    segundos <= "11111111" ;
                    next_state <= aberto ;
                else
                    trava <= '1' ;
                    segundos <= vetor_contador ;
                    next_state <= travado ;
                end if ;
            when aberto =>
                trava <= '0' ;
        end case ;
    end process;
end architecture;
