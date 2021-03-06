----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:08:15 11/19/2013 
-- Design Name: 
-- Module Name:    HalfAdder - Behavioral 
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

entity HalfAdder is
	port( a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			c : out std_logic);
end HalfAdder;

architecture Behavioral of HalfAdder is

begin
s <= a xor b;
c <= a and b;
end Behavioral;

