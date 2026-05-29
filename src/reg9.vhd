library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg9 is
    Port(
        clk : in STD_LOGIC;
        en : in STD_LOGIC;
        rst : in STD_LOGIC;
        reg_in : in STD_LOGIC_VECTOR(8 downto 0);
        reg_out : out STD_LOGIC_VECTOR(8 downto 0)
    );
end entity reg9;

Architecture Behavioral of reg9 is
    begin
        process(clk, rst)
        begin
            if rst = '1' then
                reg_out <= (others => '0');
            elsif rising_edge(clk) then
                if en = '1' then
                    reg_out <= reg_in;
                end if;
            end if;
        end process;
end architecture Behavioral;