library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSegmentDecoder is
    Port ( A: in  STD_LOGIC_VECTOR (3 downto 0);
           Cathodes : out  STD_LOGIC_VECTOR (6 downto 0);
           Anode : out  STD_LOGIC_VECTOR (3 downto 0));
end SevenSegmentDecoder;

architecture Behavioral of SevenSegmentDecoder is
begin

    Anode <= "1110"; -- Assume 4-digit display, activate only the first digit (rightmost)

    Cathodes(0) <= (not A(0) and not A(1) and not A(2) and A(3)) or (not A(0) and A(1) and not A(2) and not A(3)) or (A(0) and A(1) and not A(2) and A(3)) or (A(0) and not A(1) and A(2) and A(3));
Cathodes(1)<= (not A(0) and A(1) and not A(2) and A(3)) or (A(0) and A(1) and not A(2) and not A(3)) or (A(1) and A(2) and not A(3)) or (A(0) and A(2) and A(3));
Cathodes(2) <= (not A(0) and not A(1) and A(2) and not A(3)) or (A(0) and  A(1) and not A(2) and not A(3)) or (A(0) and A(1) and A(2));
Cathodes(3) <= (not A(0) and not A(1) and not A(2) and A(3)) or (not A(0) and A(1) and not A(2) and not A(3)) or (A(1) and A(2) and A(3)) or (A(0) and not A(1) and A(2) and not A(3)) ;
Cathodes(4)<= (not A(0) and A(3)) or (not A(0) and A(1) and not A(2)) or (not A(1) and not A(2) and A(3));
Cathodes(5)<= (not A(0) and not A(1) and A(2)) or (not A(0) and not A(1) and A(3)) or (not A(0) and A(2) and A(3)) or (A(0) and A(1) and not A(2) and A(3));
Cathodes(6)<= (not A(0) and not A(1) and not A(2)) or (not A(0) and A(1) and A(2) and A(3)) or (A(0) and A(1) and not A(2) and not A(3));


end Behavioral;