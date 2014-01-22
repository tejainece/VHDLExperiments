----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:15:39 12/15/2013 
-- Design Name: 
-- Module Name:    Counter4_2 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter4_2 is
	Port (
		a : in STD_LOGIC;
		b : in STD_LOGIC;
		c : in STD_LOGIC;
		d : in STD_LOGIC;
		
		tin : in STD_LOGIC;
		
		s : out STD_LOGIC;
		co : out STD_LOGIC;
		
		tout : out STD_LOGIC
	);
end Counter4_2;

architecture Behavioral of Counter4_2 is

COMPONENT FAdder
Port ( a : in STD_LOGIC;
b : in STD_LOGIC;
c : in STD_LOGIC;
s : out STD_LOGIC;
co : out STD_LOGIC);
END COMPONENT;

signal sINT1: STD_LOGIC;

begin

fa1: FAdder port map(
							c => a,
							a => b,
							b => c,
							s => sINT1,
							co => tout
							);

fa2: FAdder port map(
							c => tin,
							a => sINT1,
							b => d,
							s => s,
							co => co
							);

end Behavioral;

