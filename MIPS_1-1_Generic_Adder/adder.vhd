-------------------------------------------------------------------
-- Module Name:    adder - Behavioral 
-------------------------------------------------------------------
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
