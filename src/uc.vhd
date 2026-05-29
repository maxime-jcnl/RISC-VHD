library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uc is
    Port (
    -- Entrées de l'unité de contrôle
        IR : in STD_LOGIC_VECTOR(8 downto 0);
        rst : in STD_LOGIC;
        clk : in STD_LOGIC;
        run : in STD_LOGIC;
    -- Sorties de l'unité de contrôle
        -- Signaux de sélection pour le multiplexeur
        R0_out : out STD_LOGIC;
        R1_out : out STD_LOGIC;
        R2_out : out STD_LOGIC;
        R3_out : out STD_LOGIC; 
        R4_out : out STD_LOGIC;
        R5_out : out STD_LOGIC;
        R6_out : out STD_LOGIC;
        R7_out : out STD_LOGIC;
        G_out : out STD_LOGIC;
        DIN_out : out STD_LOGIC;
        -- Signaux d'activation pour les registres
        IR_in : out STD_LOGIC;
        R0_in : out STD_LOGIC;
        R1_in : out STD_LOGIC;
        R2_in : out STD_LOGIC;
        R3_in : out STD_LOGIC;
        R4_in : out STD_LOGIC;
        R5_in : out STD_LOGIC;
        R6_in : out STD_LOGIC;
        R7_in : out STD_LOGIC;
        A_in : out STD_LOGIC;
        AddSub : out STD_LOGIC;
        G_in : out STD_LOGIC;
        -- Signal de fin d'exécution de l'instruction
        done : out STD_LOGIC
    );
end entity uc;

Architecture Behavioral of uc is
    type state_type is (S0, S1, S2, S3_1, S3_2, S3_3_1, S3_3_2, S3_3_3, S3_4_1, S3_4_2, S3_4_3);
    signal current_state, next_state : state_type;

    -- Signaux internes pour le décodage de l'instruction
    signal instruction : STD_LOGIC_VECTOR(2 downto 0);
    signal rx : STD_LOGIC_VECTOR(2 downto 0);
    signal ry : STD_LOGIC_VECTOR(2 downto 0);

    begin
        -- Décodage de l'instruction IIIXXXYYY
        instruction <= IR(8 downto 6); -- III : opération
        rx <= IR(5 downto 3); -- XXX : Registre destination
        ry <= IR(2 downto 0); -- YYY : Registre source

        -- Processus de séquence pour la machine à états
        process(clk, rst)
            begin
                if rst = '1' then
                    current_state <= S0;
                elsif rising_edge(clk) then
                    current_state <= next_state;
                end if;
        end process;

        -- Processus de changement d'état
        process(current_state, run, instruction, rx, ry)
            begin
                IR_in <= '0';
                R0_in <= '0';
                R1_in <= '0';
                R2_in <= '0';
                R3_in <= '0';
                R4_in <= '0';
                R5_in <= '0';
                R6_in <= '0';
                R7_in <= '0';
                A_in <= '0';
                AddSub <= '0';
                G_in <= '0';
                done <= '0';
                R0_out <= '0';
                R1_out <= '0';
                R2_out <= '0';
                R3_out <= '0';
                R4_out <= '0';
                R5_out <= '0';
                R6_out <= '0';
                R7_out <= '0';
                G_out <= '0';
                DIN_out <= '0';

                next_state <= S0; -- Valeur par défaut 

                case current_state is
                    when S0 =>
                        if run = '1' then
                            next_state <= S1;
                        end if;
                    when S1 =>
                        IR_in <= '1'; -- Charger l'instruction dans le registre IR
                        next_state <= S2;
                    when S2 =>
                        case instruction is
                            when "000" => -- MOV
                                next_state <= S3_1;
                            when "001" => -- MVI
                                next_state <= S3_2;
                            when "010" => -- ADD
                                next_state <= S3_3_1;
                            when "011" => -- SUB
                                next_state <= S3_4_1;
                            when others =>
                                next_state <= S0; -- Instruction non reconnue, revenir à l'état initial
                        end case;
                    when S3_1 => -- MOV Rx, Ry
                        case ry is
                            when "000" => R0_out <= '1';
                            when "001" => R1_out <= '1';
                            when "010" => R2_out <= '1';
                            when "011" => R3_out <= '1';
                            when "100" => R4_out <= '1';
                            when "101" => R5_out <= '1';
                            when "110" => R6_out <= '1';
                            when "111" => R7_out <= '1';
                            when others => null;
                        end case;
                        case rx is
                            when "000" => R0_in <= '1';
                            when "001" => R1_in <= '1';
                            when "010" => R2_in <= '1';
                            when "011" => R3_in <= '1';
                            when "100" => R4_in <= '1';
                            when "101" => R5_in <= '1';
                            when "110" => R6_in <= '1';
                            when "111" => R7_in <= '1';
                            when others => null;
                        end case;
                        done <= '1'; -- Instruction terminée
                        next_state <= S0; -- Revenir à l'état initial
                    when S3_2 => -- MVI Rx, #D
                        case rx is
                            when "000" => R0_in <= '1';
                            when "001" => R1_in <= '1';
                            when "010" => R2_in <= '1';
                            when "011" => R3_in <= '1';
                            when "100" => R4_in <= '1';
                            when "101" => R5_in <= '1';
                            when "110" => R6_in <= '1';
                            when "111" => R7_in <= '1';
                            when others => null;
                        end case;
                        DIN_out <= '1'; -- Charger sur le bus la donnée immédiate D
                        done <= '1'; -- Instruction terminée
                        next_state <= S0; -- Revenir à l'état initial
                    when S3_3_1 => -- ADD Rx, Ry
                        case rx is
                            when "000" => R0_out <= '1';
                            when "001" => R1_out <= '1';
                            when "010" => R2_out <= '1';
                            when "011" => R3_out <= '1';
                            when "100" => R4_out <= '1';
                            when "101" => R5_out <= '1';
                            when "110" => R6_out <= '1';
                            when "111" => R7_out <= '1';
                            when others => null;
                        end case;
                        A_in <= '1'; -- Charger Rx dans le registre A
                        next_state <= S3_3_2;
                    when S3_3_2 =>
                        case ry is
                            when "000" => R0_out <= '1';
                            when "001" => R1_out <= '1';
                            when "010" => R2_out <= '1';
                            when "011" => R3_out <= '1';
                            when "100" => R4_out <= '1';
                            when "101" => R5_out <= '1';
                            when "110" => R6_out <= '1';
                            when "111" => R7_out <= '1';
                            when others => null;
                        end case;
                        AddSub <= '0'; -- Sélectionner l'opération d'addition
                        G_in <= '1'; -- Charger le résultat de l'addition dans le registre G
                        next_state <= S3_3_3;
                    when S3_3_3 =>
                        case rx is
                            when "000" => R0_in <= '1';
                            when "001" => R1_in <= '1';
                            when "010" => R2_in <= '1';
                            when "011" => R3_in <= '1';
                            when "100" => R4_in <= '1';
                            when "101" => R5_in <= '1';
                            when "110" => R6_in <= '1';
                            when "111" => R7_in <= '1';
                            when others => null;
                        end case;
                        G_out <= '1'; -- Sortir le résultat de l'addition sur le bus
                        done <= '1'; -- Instruction terminée
                        next_state <= S0; -- Revenir à l'état initial
                    when S3_4_1 => -- SUB Rx, Ry
                        case ry is
                            when "000" => R0_out <= '1';
                            when "001" => R1_out <= '1';
                            when "010" => R2_out <= '1';
                            when "011" => R3_out <= '1';
                            when "100" => R4_out <= '1';    
                            when "101" => R5_out <= '1';
                            when "110" => R6_out <= '1';
                            when "111" => R7_out <= '1';
                            when others => null;
                        end case;
                        A_in <= '1'; -- Charger Rx dans le registre A
                        next_state <= S3_4_2;
                    when S3_4_2 =>
                        case rx is
                            when "000" => R0_out <= '1';
                            when "001" => R1_out <= '1';
                            when "010" => R2_out <= '1';
                            when "011" => R3_out <= '1';
                            when "100" => R4_out <= '1';
                            when "101" => R5_out <= '1';
                            when "110" => R6_out <= '1';
                            when "111" => R7_out <= '1';
                            when others => null;
                        end case;
                        AddSub <= '1'; -- Sélectionner l'opération de soustraction
                        G_in <= '1'; -- Charger le résultat de la soustraction dans le registre G
                        next_state <= S3_4_3;
                    when S3_4_3 =>
                        case rx is
                            when "000" => R0_in <= '1';
                            when "001" => R1_in <= '1';
                            when "010" => R2_in <= '1';
                            when "011" => R3_in <= '1';    
                            when "100" => R4_in <= '1';
                            when "101" => R5_in <= '1';
                            when "110" => R6_in <= '1';
                            when "111" => R7_in <= '1';
                            when others => null;
                        end case;
                        G_out <= '1'; -- Sortir le résultat de la soustraction sur le bus
                        done <= '1'; -- Instruction terminée
                        next_state <= S0; -- Revenir à l'état initial
                    when others =>
                        next_state <= S0; -- Revenir à l'état initial pour tout état non défini
                end case;
            end process;
end architecture Behavioral;
