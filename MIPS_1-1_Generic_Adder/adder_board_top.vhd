-----------------------------------------------------------------------------
-- MIPS 1-1 Top Level Board VHDL file to test the generic adder
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity adder_board_top is
  port (
    sw        : in std_logic_vector (15 downto 0); -- 16 switch inputs
    LED       : out std_logic_vector (15 downto 0); -- 16 leds above switches
    -- The following three signals are use only to
    -- turn off power to the HEX segment leds.
    an        : out std_logic_vector (3 downto 0); -- Controls four 7-seg displays
    seg       : out std_logic_vector(6 downto 0); -- 7 leds per display
    dp        : out std_logic -- 1 decimal point per display
  );
end adder_board_top;

architecture adder_board_top of adder_board_top is

  -- These signals are use to wire the adder to the board level signals
  signal a_top, b_top, sum_top: STD_LOGIC_VECTOR( 3 downto 0 );
  signal carry_in_top, carry_out_top : STD_LOGIC;

begin

  -- The wiring signals in the top level, a_top, b_top, carry_top
  -- sum_top, and carry_out_top are used to connect the internal adder unit signals
  -- to the board level signals LED and sw as shown. 
  -- remember we don't need a component statement above for the adder since
  -- we are using the work.adder syntax shown here.
  adder_unit : entity work.adder generic map( N => 4 )
               port map( a => a_top, b => b_top, cin => carry_in_top, 
                         sum => sum_top, cout => carry_out_top );

-----------Wire outputs/inputs from/to adder to the board---------------
a_top <= sw(15 downto 12);
b_top <= sw(4 downto 1);
carry_in_top <= sw(0);
LED(4) <= carry_out_top;
LED(3 downto 0) <= sum_top;


----------------------Leave this untouched------------------------------
-- Turn off the 7-segment LEDs
an <= "1111";     -- wires supplying power to 4 7-seg displays
seg <= "1111111"; -- wires connecting each of 7 * 4 segments to ground
dp <= '1';        -- wire connects decimal point to ground

end adder_board_top;
