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