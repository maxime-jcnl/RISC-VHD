library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexer is
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
end entity multiplexer;

Architecture Dataflow of multiplexer is
    begin
    BUS_out <= R0 when R0_out = '1' else
               R1 when R1_out = '1' else
               R2 when R2_out = '1' else
               R3 when R3_out = '1' else
               R4 when R4_out = '1' else
               R5 when R5_out = '1' else
               R6 when R6_out = '1' else
               R7 when R7_out = '1' else
               G when G_out = '1' else
               DIN when DIN_out = '1' else
               (others => '0');
end architecture Dataflow;