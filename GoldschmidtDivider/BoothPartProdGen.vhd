----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:00:36 01/16/2014 
-- Design Name: 
-- Module Name:    BoothPartProdGen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity BoothPartProdGen is
	PORT (
		bin3: in STD_LOGIC_VECTOR(2 downto 0);
		a: in STD_LOGIC_VECTOR(15 downto 0);
		product: out STD_LOGIC_VECTOR(16 downto 0)
	);
end BoothPartProdGen;

architecture Behavioral of BoothPartProdGen is
	constant ONE17: STD_LOGIC_VECTOR(16 downto 0) := "00000000000000001";
begin
			  
PROCESS(bin3, a)
BEGIN

  if bin3 = "001" or bin3 = "010" then -- * 1
    product <= "0" & a;
  elsif bin3 = "011" then  -- * 2
	 product <= a & '0';
  elsif bin3 = "101" or bin3 = "110" then -- * -1
	 product <= std_logic_vector(unsigned(not('0' & a)) + unsigned(ONE17));
  elsif bin3 = "100" then -- * -2
	 product <= std_logic_vector(unsigned(not(a & '0')) + unsigned(ONE17));
  else
	 product <= "00000000000000000";
  end if;
END PROCESS;

end Behavioral;

