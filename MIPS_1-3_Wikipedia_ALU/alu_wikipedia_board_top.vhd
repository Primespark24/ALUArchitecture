-----------------------------------------------------------------------------
-- MIPS 1-2 Wikipedia ALU Top Level Board File
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity alu_wikipedia_board_top is
  port (
    sw        : in std_logic_vector (15 downto 0); -- 16 switch inputs
    LED       : out std_logic_vector (15 downto 0); -- 16 leds above switches
    -- The following three signals are use only to
    -- turn off power to the HEX segment leds.
    an        : out std_logic_vector (3 downto 0); -- Controls four 7-seg displays
    seg       : out std_logic_vector(6 downto 0); -- 7 leds per display
    dp        : out std_logic -- 1 decimal point per display
  );
end alu_wikipedia_board_top;

architecture alu_wikipedia_board_top of alu_wikipedia_board_top is

  -- These signals are use to wire the alu to the board level signals
  signal a_top, b_top, y_top: STD_LOGIC_VECTOR( 3 downto 0 );
  signal function_bits_top : STD_LOGIC_VECTOR( 2 downto 0 );
begin

  -- The wiring signals in the top level, a_top, b_top, y_top, function_bits_top
  -- are used to connect the internal alu unit signals
  -- to the board level signals LED and sw as shown. 
  -- remember we don't need a component statement above for the alu since
  -- we are using the work.alu syntax shown here.
  alu_unit : entity work.alu generic map( N => 4 )
               port map( A => signed(a_top), B => signed(b_top), OP => unsigned(function_bits_top), 
                         signed(Y) => y_top );

-----------Wire outputs/inputs from/to alu to the board---------------
a_top <= sw(15 downto 12);
b_top <= sw(11 downto 8);
function_bits_top <= sw(2 downto 0);
LED(3 downto 0) <= y_top;


----------------------Leave this untouched------------------------------
-- Turn off the 7-segment LEDs
an <= "1111";     -- wires supplying power to 4 7-seg displays
seg <= "1111111"; -- wires connecting each of 7 * 4 segments to ground
dp <= '1';        -- wire connects decimal point to ground

end alu_wikipedia_board_top;
