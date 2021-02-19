--------------------------------------------------------------------------------
--  Module Name:  sim_generic_adder 
--      Purpose:  Example of a programmed test bench 
-- Project Name:  Test all inputs for the 4 bit adder (has two 4 bit input)
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;        -- use this instead of STD_LOGIC_ARITH
 
ENTITY sim_generic_adder IS
END sim_generic_adder;
 
ARCHITECTURE behavioral OF sim_generic_adder IS 
  -- These signals are use to wire the adder to the board level signals
  -- input signals
  signal a_sim, b_sim  : STD_LOGIC_VECTOR( 3 downto 0 );
  signal carry_in_sim : STD_LOGIC;
  -- output signals
  signal sum_out_sim : STD_LOGIC_VECTOR( 3 downto 0 );
  signal carry_out_sim : STD_LOGIC;
  signal abc : STD_LOGIC_VECTOR( 8 downto 0 ) := "000000000";
  -- 9 bit signal for generating inputs

  ----------------------------------------------------------------------------------------
  -- Function to_string for testbench
  -- convert a STD Logic vector to a string so we can report it in the testbench console
  -- output.
  -- source: https://stackoverflow.com/questions/15406887/vhdl-convert-vector-to-string
  -----------------------------------------------------------------------------------------
  function to_string ( a: std_logic_vector) return string is
    variable b : string (1 to a'length) := (others => NUL);
    variable stri : integer := 1; 
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
        stri := stri+1;
        end loop;
    return b;
  end function;

BEGIN
    uut : entity work.adder generic map( N => 4 )
    port map( a => a_sim, b => b_sim, cin => carry_in_sim, 
            sum => sum_out_sim, cout => carry_out_sim );
 
  stim_proc: process
      variable i: INTEGER range 0 to 511; 
      variable sum_test: std_logic_vector(4 downto 0);
   begin		
      for i in 0 to 511 loop
          ---------------------------------------------------------
          -- TODO: Complete the following VHDL code
          ---------------------------------------------------------
          -- Convert variable i to 9 bit std logic vector and connect the resulting signal to abc
          abc <= STD_LOGIC_VECTOR(to_unsigned(i,9));          -- todo complete this statement
          -- Connect bit 0 of abc to carry_in_sim 
          carry_in_sim <= abc(0);  -- todo complete this statement
          -- Connect bits 1,2,3,4 of abc to b_sim
          b_sim <= abc(4 downto 1);       -- todo complete this statement
          -- Connect bits 5,6,7,8 of abc to a_sim
          a_sim <= abc(8 downto 5);        -- todo complete this statement

          wait for 10 ns;

          -- Make each signal 5 bits then add all the signals to create a validation
          -- signal
          sum_test := ("0" & a_sim) + ("0" & b_sim) + ("0000" & carry_in_sim); 

          -- compare validation signal against the carry_out_sim concatenated 
          -- with the sum_out_sim signals 
          if (carry_out_sim & sum_out_sim) /= sum_test then
            report "Failed. Value expected: " & to_string(sum_test);
            report "Inputs at failure: a: " & to_string(a_sim) & " b: " & to_string(b_sim) & " cin: " & std_logic'image(carry_in_sim) ;
          end if;
      end loop;
   end process;
END behavioral;