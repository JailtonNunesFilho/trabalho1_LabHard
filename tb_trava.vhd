library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_trava is
end entity;

architecture behavioral of tb_trava is
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal input : std_logic_vector(7 downto 0) := (others => '0');
    signal segundos : std_logic_vector(7 downto 0);
    signal trava1 : std_logic;

    constant senha : natural := 10;
    constant tempo_para_desarme : natural := 5;
begin
    t1: entity work.trava(rtl)
        generic map (senha => senha, tempo_para_desarme => tempo_para_desarme)
        port map (clock => clock, reset => reset, input => input, segundos => segundos, trava1 => trava1);

    clock1: process
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;

    estimulo: process
    begin
        reset <= '1';
        wait for 10 ns; -- 10
        
        assert (trava1 = '1')
            report "Erro no Reset: A trava deveria estar fechada"
            severity failure;
        assert (to_integer(unsigned(segundos)) = tempo_para_desarme)
            report "Erro no Reset: O tempo deveria ser reiniciado para " & integer'image(tempo_para_desarme)
            severity failure;
        -------
        reset <= '0'; 
        wait for 10 ns; -- 20

        input <= std_logic_vector(to_unsigned(0, 8));
        wait for 10 ns; -- 30

        assert (unsigned(segundos) = (tempo_para_desarme - 1))
            report "Erro na Contagem: O tempo deveria ter diminuido para " & integer'image(tempo_para_desarme - 1)
            severity failure;
            
        assert (trava1 = '1')
            report "Erro na Contagem: A trava deveria ficar fechada com senha errada"
            severity failure;
        -------
        input <= std_logic_vector(to_unsigned(senha, 8)); 
        wait for 10 ns; -- 40

        assert (trava1 = '0')
            report "Erro no Desbloqueio: A trava deveria abrir com a senha correta"
            severity failure;
        
        assert (unsigned(segundos) > 0) 
            report "Erro no Desbloqueio: O contador deveria parar e não zerar"
            severity failure;
        -------
        input <= std_logic_vector(to_unsigned(99, 8));
        wait for 10 ns; -- 50

        assert (trava1 = '0')
            report "Erro no Re-bloqueio: A trava não deveria fechar denovo ao mudar o input"
            severity failure;

        reset <= '1' ;
        wait for 10 ns;
        reset <= '0' ;
        wait for 10 ns;
        wait for 50 ns; 
        -------
        assert (unsigned(segundos) = 0)
            report "Erro: O contador deveria ter chegado a 0"
            severity failure;

        wait for 10 ns ;

        -- replicando o teste anterior para verificar se ele funciona novamente.
        reset <= '1';
        wait for 10 ns; -- 10
        
        assert (trava1 = '1')
            report "Erro no Reset: A trava deveria estar fechada"
            severity failure;
        assert (to_integer(unsigned(segundos)) = tempo_para_desarme)
            report "Erro no Reset: O tempo deveria ser reiniciado para " & integer'image(tempo_para_desarme)
            severity failure;
        -------
        reset <= '0'; 
        wait for 10 ns; -- 20

        input <= std_logic_vector(to_unsigned(0, 8));
        wait for 10 ns; -- 30

        assert (unsigned(segundos) = (tempo_para_desarme - 1))
            report "Erro na Contagem: O tempo deveria ter diminuido para " & integer'image(tempo_para_desarme - 1)
            severity failure;
            
        assert (trava1 = '1')
            report "Erro na Contagem: A trava deveria ficar fechada com senha errada"
            severity failure;
        -------
        input <= std_logic_vector(to_unsigned(senha, 8)); 
        wait for 10 ns; -- 40

        assert (trava1 = '0')
            report "Erro no Desbloqueio: A trava deveria abrir com a senha correta"
            severity failure;
        
        assert (unsigned(segundos) > 0) 
            report "Erro no Desbloqueio: O contador deveria parar e não zerar"
            severity failure;
        -------
        input <= std_logic_vector(to_unsigned(99, 8));
        wait for 10 ns; -- 50

        assert (trava1 = '0')
            report "Erro no Re-bloqueio: A trava não deveria fechar denovo ao mudar o input"
            severity failure;

        reset <= '1' ;
        wait for 10 ns;
        reset <= '0' ;
        wait for 10 ns;
        wait for 50 ns; 
        -------
        assert (unsigned(segundos) = 0)
            report "Erro: O contador deveria ter chegado a 0"
            severity failure;

        report "Fim do teste trava" severity note;
        wait;
    end process;

end architecture;