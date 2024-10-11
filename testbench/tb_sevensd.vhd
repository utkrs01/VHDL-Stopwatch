library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_SevenSegmentDecoder is
end tb_SevenSegmentDecoder;

architecture Behavioral of tb_SevenSegmentDecoder is

    -- Component declaration for the Unit Under Test (UUT)
    component SevenSegmentDecoder
        Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
               Cathodes : out  STD_LOGIC_VECTOR (6 downto 0);
               Anode : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;

    -- Testbench signals
    signal A : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal Cathodes : STD_LOGIC_VECTOR (6 downto 0);
    signal Anode : STD_LOGIC_VECTOR (3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: SevenSegmentDecoder
        Port map (
            A => A,
            Cathodes => Cathodes,
            Anode => Anode
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply inputs and wait for a while
        A <= "0000"; wait for 100 ns; -- Test with 0
        A <= "0001"; wait for 100 ns; -- Test with 1
        A <= "0010"; wait for 100 ns; -- Test with 2
        A <= "0011"; wait for 100 ns; -- Test with 3
        A <= "0100"; wait for 100 ns; -- Test with 4
        A <= "0101"; wait for 100 ns; -- Test with 5
        A <= "0110"; wait for 100 ns; -- Test with 6
        A <= "0111"; wait for 100 ns; -- Test with 7
        A <= "1000"; wait for 100 ns; -- Test with 8
        A <= "1001"; wait for 100 ns; -- Test with 9
        A <= "1010"; wait for 100 ns; -- Test with A
        A <= "1011"; wait for 100 ns; -- Test with B
        A <= "1100"; wait for 100 ns; -- Test with C
        A <= "1101"; wait for 100 ns; -- Test with D
        A <= "1110"; wait for 100 ns; -- Test with E
        A <= "1111"; wait for 100 ns; -- Test with F

        -- End the simulation
        wait;
    end process;

end Behavioral;