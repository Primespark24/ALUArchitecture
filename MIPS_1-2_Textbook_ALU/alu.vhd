-------------------------------------------------------------------
-- Module Name:    alu - Behavioral 
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
