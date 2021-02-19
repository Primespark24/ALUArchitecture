--------------------------------------------------------------------------------
--  Module Name:  sim_textbook_alu 
--      Purpose:  Example of a programmed test bench 
-- Project Name:  Test all inputs for the 4 bit alu (has two 4 bit input)
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;        -- use this instead of STD_LOGIC_ARITH
 
ENTITY sim_textbook_alu IS
END sim_textbook_alu;
 
ARCHITECTURE behavioral OF sim_textbook_alu IS 
  -- These signals are use to wire the alu to the board level signals
  -- input signals
  signal a_sim, b_sim  : STD_LOGIC_VECTOR( 3 downto 0 );
  signal function_bits_sim : STD_LOGIC_VECTOR( 2 downto 0 );
  -- output signals
  signal y_sim : STD_LOGIC_VECTOR( 3 downto 0 );

  -- 11 bit signal for generating all possible inputs and functions to the ALU
  -- four bits for a input
  -- four bits for b input
  -- three bits for function input f
  signal abf : STD_LOGIC_VECTOR( 10 downto 0 ) := "00000000000";
 

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
    uut : entity work.alu generic map( N => 4 )
    port map( a => a_sim, b => b_sim, f => function_bits_sim, 
            y => y_sim );
 
  stim_proc: process
      variable i: INTEGER range 0 to 2047; 
      variable alu_test: std_logic_vector(4 downto 0);
   begin		
      for i in 0 to 2047 loop
          -- Convert i to 11 bit std logic vector and connect signal to abf
          abf <= std_logic_vector(to_unsigned(i, 11));
          -- Connect bits 0,1,2 of abf to the function_bits_sim
          function_bits_sim <= abf(2 downto 0);
          -- Connect bits 3,4,5,6 of abc to b_sim
          b_sim <= abf(6 downto 3);
          -- Connect bits 7,8,9,10 of abc to a_sim
          a_sim <= abf(10 downto 7);

          wait for 10 ns;

          -- TODO: verify that the ALU is computing the correct values here
          -- TODO: do this by computing what each value should be and comparing
          -- TODO: to the y_sim output value from the ALU. Look at the MIPS_1-1
          -- TODO: simulation for an example verification
          -- Make each signal 5 bits then add all the signals to create a validation
          -- signal
          alu_test := ("0" & a_sim) + ("0" & b_sim) + ("0000" & function_bits_sim); 
          -- TODO: Currently this VHDL reports values of all ALU computations
          -- TODO: only report and output if the alu computation is not correct.
          if (y_sim) /= alu_test then
            report "a: " & to_string(a_sim) & " b: " & to_string(b_sim);
            report "f: " & to_string(function_bits_sim);
            report "y: " & to_string(y_sim);
          end if;
      end loop;
   end process;
END behavioral;