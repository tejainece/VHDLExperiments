----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:26 11/21/2013 
-- Design Name: 
-- Module Name:    SelectorLSB - Behavioral 
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

library work;
use work.MyTypes.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SelectorLSB is
	 generic (
			  num_sum: integer := 0
	 );
    Port ( cIn     : in   PairT;
			  cSel    : in   std_logic;
			  cOut    : out  std_logic;
			  sumIn   : in   PairArr(num_sum downto 0);
			  sumOut  : out  std_logic_vector(num_sum downto 0)
	);
end SelectorLSB;

architecture Behavioral of SelectorLSB is

begin

process (cIn, cSel, sumIn)
begin
	if (cSel = '0') then
		for index in 0 to num_sum loop
			sumOut(index)  <= sumIn(index)(0);
		end loop;
		cOut <= cIn(0);
	else
		for index in 0 to num_sum loop
			sumOut(index)  <= sumIn(index)(1);	
		end loop;
		cOut <= cIn(1);
	end if;
end process;

end Behavioral;