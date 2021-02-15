# Computer Architecture
## MIPS-1-3 Wikipedia Based ALU

## Introduction

The following VHDL code was originally given on Wikipedia. Some modifications were made to match the number of instructions for this ALU design to the number of instructions in the textbook ALU design. 

1.	Locate alu.vhd and open it with vscode.  Compare the code there to what is given below. They should be the same. 

2. Unfortunately, the simulation code (sim_testbench/sim_wikipedia_alu.vhd) is not completed and you need to complete the simulation code to verify the processor. The test bench code should check all possible combinations of the 4-bit inputs a and b and the 1 carry input. After you fix the test bench code, and verify the processor, go ahead with the next step. Please note. The top level hardware code (alu_textbook_board_top.vhd) is complete and _will work correctly_ once it has been generated and the bitstream sent to the board. 

3.	How many resources of the FPGA  (e.g. slice LUTs, Slices, LUT as logic, Bonded IOBs) are used in the textbook's ALU design?	 To find this for your project, under the Implementation menu, click on "Open Synthezied Design". After this opens, from the main _Reports_ menu at the top of Vivado, select the "Report Utilization..." option. YOu will see four columns. Put your answers from each of these columns in the box below where indicated:
     ```
          Put your answers in the areas indicated...
          Slice LUTs used (out of 20800 total): 
          Slices used (out of 8150): 
          LUT as Logic (out of 20800) : 
          Bonded IOBs use (out of 106): 
     ```				
4.	This ALU has 7 instructions. What is the ratio of slices to instructions? (slices / instruction)
     ```
          replace this line with your answer.
     ```	
5. Which of the two ALUs (textbook or wikipedia) is more efficient in terms of resources used or are they the same? Explain any differences or similarities you find.

     ```
          replace this line with your answer.
     ```	

6. Now, program the BASYS 3 board using the bitstream generated from this project. Set the switches as neccessary so that the  _a_ input contains 3 and the _b_ input contains 1. Set the switches so that the ALU will compute the add function. What LEDs on the board should light up? Do they light up correctly? Why or why not? Put your answers in the box below:	
     ```
          A. What switches did you set:
          B. What LED lights lit up:
          C. Is this correct?
     ```	

### VHDL CODE for Wikipedia Processor
```vhdl
-------------------------------------------------
-- Module Name: alu - Wikipedia 
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;   

entity alu is
generic ( N : integer := 32 );
port (  -- the alu connections to external circuitry:
     A  : in  signed(N-1 downto 0);   -- operand A
     B  : in  signed(N-1 downto 0);   -- operand B
     OP : in  unsigned(2 downto 0);   -- opcode
     Y  : out signed(N-1 downto 0));  -- operation result
end alu;

architecture behavioral of alu is
signal diff : signed(N-1 downto 0);
begin
diff <= A - B;
     process ( OP, A, B, diff )
     begin
          case OP is  -- decode the opcode and perform the operation:
          when "000" =>  Y <= A and B;       -- A & B
          when "001" =>  Y <= A or B;        -- A | B
          when "010" =>  Y <= A + B;         -- A + B
          when "011" =>  Y <= (others => 'X'); -- not implemented
          when "100" =>  Y <= A and not B;   -- A & ~B
          when "101" =>  Y <= A or not B;    -- A | ~B
          when "110" =>  Y <= diff;          -- A - B
          when "111" =>  Y <= (N-1 downto 1 => '0') & diff(N-1);  -- SLT
          when others => Y <= (others => 'X'); -- not implemented
          end case; 
     end process;
end behavioral;
```

# Data Type Conversions in VHDL
When you examine the code, you will notice the various data type conversions and typecasts. The next figure demonstrates how to convert (and typecast) between various data types in VHDL.

![Data Type Conversions](VHDL_Conversions.jpg)

# Important notes:

* If you leave the Vivado project running when you got to re-run the project generation (./gen.sh), the generation will fail! You MUST close Vivado when re-generating a project!
* Always READ the outputs of the ./gen.sh script. If you see Error messages, something is wrong and you will need to fix the errors!
* Warnings are not neccessarily a problem.

# Generating and running a simulation
Open a bash terminal in vscode, and run the following command in the terminal:
```
./gen.sh
```
This will generate the Vivado project automatically. Open the folder that the script generates and find and run the .xpr file for the vivado project.





