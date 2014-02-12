----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:34 11/19/2013 
-- Design Name: 
-- Module Name:    ResultGen - Behavioral 
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

entity ResultGen is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
			  s : out PairT;
			  c : out PairT);
           --s0 : out  STD_LOGIC;
           --s1 : out  STD_LOGIC;
           --c0 : out  STD_LOGIC;
           --c1 : out  STD_LOGIC);
end ResultGen;

architecture Behavioral of ResultGen is

begin
s <= (a xnor b) & (a xor b);

c <= (a or b) & (a and b);

end Behavioral;

