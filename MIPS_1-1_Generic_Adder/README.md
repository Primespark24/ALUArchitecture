# Computer Architecture
## MIPS-1-1 Generic Adder

## Introduction

The following VHDL code implements both board code AND testbench code for a generic N bit adder.  
A generic adder can be instantiated (implemented) in VHDL to add as many bits as you need. For this project you will simply be adding together two 4 bit numbers (plus a carry in signal) in order to create a four bit sum with a carry out signal.


1.	The follow VHDL code has already been supplied in this project. 
2.	Review the top-level test bench template file ```./sim_testbench/sim_generic_adder.vhd``` 
3.	Pretend you are an Intel engineer. You don’t want to lose your job if the adder fails due to a design flaw. Because of this, we have decided to verify the correctness of ```adder.vhd``` by testing all possible input combinations using the testbench code you reviewed in step 2. 
4. Unfortunately, the code is not completed and you need to complete this code and make it work. The test bench code should check all possible combinations of the 4-bit inputs a and b and the 1 carry input. After you fix the test bench code, and verify the processor, go ahead with step 5.
5.  Please note. The top level hardware code for the board _will work correctly_ once it has been generated and the bitstream sent to the board. 

```vhdl
----------------------------------------------------------
-- Module Name:    adder - Behavioral 
----------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity adder is
  generic ( N: integer := 8 );
  port ( a, b: in STD_LOGIC_VECTOR( N-1 downto 0 );
          cin: in STD_LOGIC;
	   sum: out STD_LOGIC_VECTOR( N-1 downto 0 );
	  cout: out STD_LOGIC );
end adder;
architecture Behavioral of adder is
  signal result: STD_LOGIC_VECTOR( N downto 0 );
begin
  result <= ( "0" & a ) + ( "0" & b ) + cin;
  sum    <= result( N-1 downto 0 );
  cout   <= result(N);  
end Behavioral;

```
# How to Generate and Run the Testbench and Adder on the Basys 3 Board
You must have gitbash, Vivado and vscode installed on your machine. Open this project in vscode, and set the default terminal to bash (in vscode select View | Commmand Palette | Terminal: Select Default Shell | Git Bash) then, open a bash terminal in vscode (Terminal | New Terminal), and run the following command:
```
./gen.sh
```
The gen.sh bash script runs the setup_project.tcl script and generates the Vivado project ```./vivado_generated_adder/adder_board_top.xpr```. If this folder / file is missing, you have not fixed or completed the hardware design in the ```sim_generic_adder.vhd``` file correctly. After synthesis completes successfully you will see the vivado project folder called 
The gen.sh bash script runs the setup_project.tcl script and generates the Vivado project ```./vivado_generated_adder/adder_board_top.xpr```. You can double-click on the this .xpr file to start vivado and program your Basys 3 board OR run the top level simulation file.


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
This will generate the Vivado project automatically. Open the folder multibitshifter/ that the script generates and run the .xpr file for the vivado project.





