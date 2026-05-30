library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addsub is
    Port (
        x : in STD_LOGIC_VECTOR(8 downto 0);
        y : in STD_LOGIC_VECTOR(8 downto 0);
        AddSub : in STD_LOGIC;
        result : out STD_LOGIC_VECTOR(8 downto 0)
    );
end entity addsub;

Architecture Dataflow of addsub is
    begin 
    result <= std_logic_vector(signed(x) + signed(y)) when AddSub = '0' else
              std_logic_vector(signed(x) - signed(y));
end architecture Dataflow;