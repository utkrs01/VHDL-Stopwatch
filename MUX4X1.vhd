library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4x1 is
    Port (
        sel : in STD_LOGIC_VECTOR(1 downto 0); -- 2-bit select signal
        d0 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 0
        d1 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 1
        d2 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 2
        d3 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 3
        y : out STD_LOGIC_VECTOR (3 downto 0) -- Output
    );
end MUX4x1;

architecture Behavioral of MUX4x1 is
begin
    process(sel, d0, d1, d2, d3)
    begin
        case sel is
            when "00" => y <= d0; -- Select input 0
            when "01" => y <= d1; -- Select input 1
            when "10" => y <= d2; -- Select input 2
            when "11" => y <= d3; -- Select input 3
            when others => y <= "0000"; -- Default output (shouldn't happen)
        end case;
    end process;
end Behavioral;