library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity processor_top is
    Port(
        -- Entrée
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        run : in STD_LOGIC;
        DIN : in STD_LOGIC_VECTOR(8 downto 0);
        -- Sortie
        bus_output : out STD_LOGIC_VECTOR(8 downto 0);
        done : out STD_LOGIC
    );
end entity processor_top;


Architecture Structural of processor_top is
-- Composants internes
    component uc is
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
    end component uc;

    component reg9 is
        Port(
            clk : in STD_LOGIC;
            en : in STD_LOGIC;
            rst : in STD_LOGIC;
            reg_in : in STD_LOGIC_VECTOR(8 downto 0);
            reg_out : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component reg9;

    component multiplexer is
        Port(
            -- Selecteurs de registres
            R0_out : in STD_LOGIC;
            R1_out : in STD_LOGIC;
            R2_out : in STD_LOGIC;
            R3_out : in STD_LOGIC;
            R4_out : in STD_LOGIC;
            R5_out : in STD_LOGIC;
            R6_out : in STD_LOGIC;
            R7_out : in STD_LOGIC;
            G_out : in STD_LOGIC;
            
            DIN_out : in STD_LOGIC;

            -- Entrées du mux
            R0 : in STD_LOGIC_VECTOR(8 downto 0);
            R1 : in STD_LOGIC_VECTOR(8 downto 0);
            R2 : in STD_LOGIC_VECTOR(8 downto 0);
            R3 : in STD_LOGIC_VECTOR(8 downto 0);
            R4 : in STD_LOGIC_VECTOR(8 downto 0);
            R5 : in STD_LOGIC_VECTOR(8 downto 0);
            R6 : in STD_LOGIC_VECTOR(8 downto 0);
            R7 : in STD_LOGIC_VECTOR(8 downto 0);
            G : in STD_LOGIC_VECTOR(8 downto 0);
            DIN : in STD_LOGIC_VECTOR(8 downto 0);
            
            -- Sortie du mux
            BUS_out : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component multiplexer;

    component addsub is
        Port (
            x : in STD_LOGIC_VECTOR(8 downto 0);
            y : in STD_LOGIC_VECTOR(8 downto 0);
            AddSub : in STD_LOGIC;
            result : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component addsub;

    -- Déclaration des signaux internes
    signal Bus_Wires : STD_LOGIC_VECTOR(8 downto 0); -- Bus interne pour connecter les composants (sortie du mux)

    signal R0_data : STD_LOGIC_VECTOR(8 downto 0);
    signal R1_data : STD_LOGIC_VECTOR(8 downto 0);
    signal R2_data : STD_LOGIC_VECTOR(8 downto 0);
    signal R3_data : STD_LOGIC_VECTOR(8 downto 0);
    signal R4_data : STD_LOGIC_VECTOR(8 downto 0);
    signal R5_data : STD_LOGIC_VECTOR(8 downto 0);
    signal R6_data : STD_LOGIC_VECTOR(8 downto 0);
    signal R7_data : STD_LOGIC_VECTOR(8 downto 0);

    signal A_data : STD_LOGIC_VECTOR(8 downto 0);
    signal AddSub_signal : STD_LOGIC;
    signal AddSub_result : STD_LOGIC_VECTOR(8 downto 0);
    signal G_data : STD_LOGIC_VECTOR(8 downto 0);
    signal IR_data : STD_LOGIC_VECTOR(8 downto 0);
    signal DIN_data : STD_LOGIC_VECTOR(8 downto 0); -- Lien entre le mux et le DIN
    
    signal R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out : STD_LOGIC;
    signal G_out, DIN_out : STD_LOGIC;
    signal IR_in, R0_in, R1_in, R2_in, R3_in, R4_in, R5_in, R6_in, R7_in : STD_LOGIC;
    signal A_in, G_in : STD_LOGIC;d



