# Computer Architecture
## MIPS-1-2 Textbook ALU

## Introduction

The following VHDL code implements a generic N bit ALU from your textbook. Notice there are a couple of changes to accommodate the change to IEEE.NUMERIC_STD.all;

1.	Locate alu.vhd and open it with vscode.  Compare the code there to what is given below. They should be the same. 

2. Unfortunately, the simulation code (sim_testbench/sim_textbook_alu.vhd) is not completed and you need to complete the simulation code to verify the processor. The test bench code should check all possible combinations of the 4-bit inputs a and b and the 1 carry input. After you fix the test bench code, and verify the processor, go ahead with the next step. Please note. The top level hardware code (alu_textbook_board_top.vhd) is complete and _will work correctly_ once it has been generated and the bitstream sent to the board. 
    
3.	What is a Slice or LUT?  Quickly read about an Artix 7 FPGA slice starting on page 18 of the following document (don’t spend a huge amount of time here):  https://www.xilinx.com/support/documentation/user_guides/ug474_7Series_CLB.pdf 
    A slice is a group of hardware that provides logic, arithmetic and ROM Functions.
    A LUT or Look Up Table is an object that acts like a small Ram chip and allows for fast lookup of items needed by the FPGA

4.	How many resources of the FPGA  (e.g. slice LUTs, Slices, LUT as logic, Bonded IOBs) are used in the textbook's ALU design?	 To find this for your project, under the Implementation menu, click on "Open Synthezied Design". After this opens, from the main _Reports_ menu at the top of Vivado, select the "Report Utilization..." option. You will see four columns. Put your answers from each of these columns in the box below where indicated:
    ```
        Put your answers in the areas indicated...
        Slice LUTs used (out of 20800 total): 4  
        Slices used (out of 8150): 2
        LUT as Logic (out of 20800) : 4 
        Bonded IOBs use (out of 106): 37
    ```							 	
5.	This ALU has 7 instructions. What is the ratio of slices to instructions? (slices / instruction)
    ```
        2 to 7, slices to instructions
    ```	
6. Now, program the BASYS 3 board using the bitstream generated from this project. Set the switches as neccessary so that the  _a_ input to the alu contains 3 and the _b_ input contains 1. Set the switches so that the ALU will compute the add function (what does the function input require in this case?). What LEDs on the board should light up? Do they light up correctly? Why or why not? Put your answers in the box below
    ```
        A. What switches did you set (look at the board for the labels):
        B. What LEDs lit up (look at the board for the id labels):
        C. Is this correct?
    ```		

### VHDL CODE for Textbook Processor
```vhdl
    -------------------------------------------------------------------
    -- Module Name:    textbook alu - Behavioral 
    -------------------------------------------------------------------
    library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use IEEE.STD_LOGIC_UNSIGNED.all;
    use IEEE.NUMERIC_STD.all;        -- use this instead of STD_LOGIC_ARITH

    entity alu is
        generic ( N : integer := 32 );
        port ( a, b : in STD_LOGIC_VECTOR( N-1 downto 0 );
        f : in STD_LOGIC_VECTOR( 2 downto 0 );
        Y : out STD_LOGIC_VECTOR( N-1 downto 0 ) );
    end alu;

    architecture Behavioral of alu is
        signal sum, bout : STD_LOGIC_VECTOR( N-1 downto 0 );
    begin
        bout <= B when ( f(2) = '0' ) else not B;
        sum <= a + bout + f(2);  -- 2's complement depends on f(2)
                
        process ( a, bout, sum, f(1 downto 0) )
        begin
            case f(1 downto 0) is 
                when "00" => y <= a and bout;
                when "01" => y <= a or bout;
                when "10" => y <= sum;
                when "11" => y <= (N-1 downto 1 => '0') & sum(N-1); -- zero extend
                when others => Y <= (others => 'X');
            end case;
        end process;
    end Behavioral; 
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





