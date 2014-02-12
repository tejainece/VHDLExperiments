----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:27:29 11/20/2013 
-- Design Name: 
-- Module Name:    Selector - Behavioral 
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

entity Selector is
	 generic (
			  num_sum: integer := 0;
			  num_buffer: integer := 0
	 );
    Port ( cIn     : in   PairT;
			  cSel    : in   PairT;
			  cOut    : out   PairT;
			  sumIn   : in   PairArr(num_sum downto 0);
			  sumOut  : out  PairArr(num_sum downto 0);
			  bufferIn: in   PairArr(num_buffer downto 0);
			  bufferOut:out  PairArr(num_buffer downto 0));
end Selector;

architecture Behavioral of Selector is

begin

process (cIn, cSel, sumIn)
begin
	if (cSel(0) = cSel(1)) then
		if (cSel(0) = '0') then
			for index in 0 to num_sum loop
				sumOut(index)  <= (1 downto 0 => sumIn(index)(0));
			end loop;
			cOut <= (1 downto 0 => cIn(0));
		else
			for index in 0 to num_sum loop
				sumOut(index)  <= (1 downto 0 => sumIn(index)(1));	
			end loop;
			cOut <= (1 downto 0 => cIn(1));
		end if;
	else
		for index in 0 to num_sum loop
			sumOut  <= sumIn;	
		end loop;
		cOut <= cIn;
	end if;
end process;

bufferOut <= bufferIn;
end Behavioral;