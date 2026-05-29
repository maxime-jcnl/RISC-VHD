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
    signal R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out : STD_LOGIC;
    signal G_out, DIN_out : STD_LOGIC;
    signal IR_in, R0_in, R1_in, R2_in, R3_in, R4_in, R5_in, R6_in, R7_in : STD_LOGIC;
    signal A_in, G_in : STD_LOGIC;

    begin
    -- Unité de contrôle
    U_UC :  uc port map (
        rst => rst, clk => clk,
        run => run, 
        done => done,

        IR => IR_data,
        DIN_out => DIN_out,
        IR_in => IR_in, 
        AddSub => AddSub_signal,
        G_in => G_in, A_in => A_in, G_out => G_out,

        R0_out => R0_out, R1_out => R1_out, R2_out => R2_out, R3_out => R3_out,
        R4_out => R4_out, R5_out => R5_out, R6_out => R6_out, R7_out => R7_out,
        
        R0_in => R0_in, R1_in => R1_in, R2_in => R2_in, R3_in => R3_in, 
        R4_in => R4_in, R5_in => R5_in, R6_in => R6_in, R7_in => R7_in
        
        
    );

    -- Multiplexeur
    U_MUX : multiplexer port map (
        R0_out => R0_out, R1_out => R1_out, R2_out => R2_out, R3_out => R3_out,
        R4_out => R4_out, R5_out => R5_out, R6_out => R6_out, R7_out => R7_out,
        G_out => G_out, DIN_out => DIN_out,
        R0 => R0_data, R1 => R1_data, R2 => R2_data, R3 => R3_data,
        R4 => R4_data, R5 => R5_data, R6 => R6_data, R7 => R7_data,
        G => G_data, DIN => DIN,
        BUS_out => Bus_Wires
    );

    -- Addsub
    U_ADDSUB : addsub port map (
        x => A_data,
        y => Bus_Wires,
        AddSub => AddSub_signal,
        result => AddSub_result
    );

    -- Registres
    U_R0 : reg9 port map (clk => clk, en => R0_in, rst => rst, reg_in => Bus_Wires, reg_out => R0_data);
    U_R1 : reg9 port map (clk => clk, en => R1_in, rst => rst, reg_in => Bus_Wires, reg_out => R1_data);
    U_R2 : reg9 port map (clk => clk, en => R2_in, rst => rst, reg_in => Bus_Wires, reg_out => R2_data);
    U_R3 : reg9 port map (clk => clk, en => R3_in, rst => rst, reg_in => Bus_Wires, reg_out => R3_data);
    U_R4 : reg9 port map (clk => clk, en => R4_in, rst => rst, reg_in => Bus_Wires, reg_out => R4_data);
    U_R5 : reg9 port map (clk => clk, en => R5_in, rst => rst, reg_in => Bus_Wires, reg_out => R5_data);
    U_R6 : reg9 port map (clk => clk, en => R6_in, rst => rst, reg_in => Bus_Wires, reg_out => R6_data);
    U_R7 : reg9 port map (clk => clk, en => R7_in, rst => rst, reg_in => Bus_Wires, reg_out => R7_data);

    U_A : reg9 port map (clk => clk, en => A_in, rst => rst, reg_in => Bus_Wires, reg_out => A_data);
    U_G : reg9 port map (clk => clk, en => G_in, rst => rst, reg_in => AddSub_result, reg_out => G_data);
    U_IR : reg9 port map (clk => clk, en => IR_in, rst => rst, reg_in => DIN, reg_out => IR_data);
    -- Sortie du bus
    bus_output <= Bus_Wires;
end architecture Structural;
