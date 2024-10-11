library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Timing_block_tb is
end Timing_block_tb;

architecture Behavioral of Timing_block_tb is

    -- Signals for the input and output of the DUT (Device Under Test)
    signal a_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal b_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal c_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal d_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal clk_in_tb : STD_LOGIC := '0';
    signal Anodes_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal Cathodes_tb : STD_LOGIC_VECTOR(6 downto 0);

    -- Clock period for simulation (for a 100 MHz clock)
    constant CLK_PERIOD : time := 10 ns;

    -- DUT component declaration
    component Timing_block
        Port (
            a : in STD_LOGIC_VECTOR (3 downto 0);
            b : in STD_LOGIC_VECTOR (3 downto 0);
            c : in STD_LOGIC_VECTOR (3 downto 0);
            d : in STD_LOGIC_VECTOR (3 downto 0);
            clk_in : in STD_LOGIC;
            Anodes : out STD_LOGIC_VECTOR(3 downto 0);
            Cathodes : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

begin

    -- Instantiate the DUT (Timing_block)
    uut: Timing_block
        port map (
            a => a_tb,
            b => b_tb,
            c => c_tb,
            d => d_tb,
            clk_in => clk_in_tb,
            Anodes => Anodes_tb,
            Cathodes => Cathodes_tb
        );

    -- Clock process to generate a 100 MHz clock
    clk_process: process
    begin
        while true loop
            clk_in_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_in_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process clk_process;

    -- Stimulus process
    stim_process: process
    begin
        -- Initialize inputs
        a_tb <= "0001"; -- Input digit 0
        b_tb <= "0010"; -- Input digit 1
        c_tb <= "0011"; -- Input digit 2
        d_tb <= "0100"; -- Input digit 3

        -- Wait for several clock cycles to observe behavior
        wait for 10 ms;

        -- Stop the simulation after a certain time
        wait;
    end process stim_process;

end Behavioral;