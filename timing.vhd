library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Timing_block is
    Port (
        a : in STD_LOGIC_VECTOR (3 downto 0); -- Input for digit 0
        b : in STD_LOGIC_VECTOR (3 downto 0); -- Input for digit 1
        c : in STD_LOGIC_VECTOR (3 downto 0); -- Input for digit 2
        d : in STD_LOGIC_VECTOR (3 downto 0); -- Input for digit 3
        clk_in : in STD_LOGIC; -- 100 MHz input clock
        Anodes : out STD_LOGIC_VECTOR(3 downto 0); -- Anode signal for the display
        Cathodes : out STD_LOGIC_VECTOR(6 downto 0) -- Cathode signal for the 7-segment display
    );
end Timing_block;

architecture Behavioral of Timing_block is

    constant DIVIDER : integer := 50000; -- Divider value for 1 kHz clock
    signal counter : integer := 0;
    signal new_clk : STD_LOGIC := '0'; -- 1 kHz clock signal
    signal mux_select : STD_LOGIC_VECTOR(1 downto 0); -- MUX selector for digit selection
    signal mux_output : STD_LOGIC_VECTOR(3 downto 0); -- Output of the MUX (selected digit)

    component MUX4x1 is 
        Port (
            sel : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit select signal
            d0 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 0
            d1 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 1
            d2 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 2
            d3 : in STD_LOGIC_VECTOR (3 downto 0); -- Input 3
            y : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit Output
        );
    end component;

    component SevenSegmentDecoder is 
        Port (
            A : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit input
            Cathodes: out STD_LOGIC_VECTOR (6 downto 0) -- 7-segment display output
        );
    end component;

begin    
    -- Process 1: Clock divider from 100 MHz to 1 kHz (1 ms period)
    new_clk_process: process(clk_in)
    begin
        if rising_edge(clk_in) then
            if counter = DIVIDER then
                counter <= 0;
                new_clk <= not new_clk; -- Toggle the new clock signal every 50,000 cycles
            else
                counter <= counter + 1;
            end if;
        end if;
    end process new_clk_process;

    -- Process 2: MUX select signal (2-bit counter to select one of the 4 digits)
    mux_select_process: process(new_clk)
    begin
        if rising_edge(new_clk) then
            mux_select <= mux_select + 1;
        end if;
    end process mux_select_process;

    -- Instantiate the 4x1 MUX to select the correct digit
    mux_inst : MUX4x1
        port map (
            sel => mux_select,
            d0 => a,
            d1 => b,
            d2 => c,
            d3 => d,
            y => mux_output
        );

    -- Instantiate the Seven Segment Decoder to display the selected digit
    decoder_inst : SevenSegmentDecoder
        port map (
            A => mux_output,
            Cathodes => Cathodes
        );

    -- Process 3: Anode signal generation (to activate the correct digit on the display)
    ANODE_select: process(mux_select)
    begin
        case mux_select is
            when "00" => Anodes <= "1110"; -- Activate the first digit (anode 0)
            when "01" => Anodes <= "1101"; -- Activate the second digit (anode 1)
            when "10" => Anodes <= "1011"; -- Activate the third digit (anode 2)
            when "11" => Anodes <= "0111"; -- Activate the fourth digit (anode 3)
            when others => Anodes <= "1111"; -- Deactivate all digits (shouldn't happen)
        end case;
    end process ANODE_select;

end Behavioral;
