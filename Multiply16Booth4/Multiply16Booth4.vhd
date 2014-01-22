----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:22:23 01/22/2014 
-- Design Name: 
-- Module Name:    Multiply16Booth4 - Behavioral 
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

entity Multiply16Booth4 is
	PORT (
		a: IN STD_LOGIC_VECTOR(15 downto 0);
		b: IN STD_LOGIC_VECTOR(15 downto 0);
		o: OUT STD_LOGIC_VECTOR(15 downto 0));
end Multiply16Booth4;

architecture Behavioral of Multiply16Booth4 is
COMPONENT BoothPartProdGen is
	PORT (
		bin3: in STD_LOGIC_VECTOR(2 downto 0);
		a: in STD_LOGIC_VECTOR(15 downto 0);
		product: out STD_LOGIC_VECTOR(16 downto 0)
	);
end COMPONENT;

COMPONENT BoothPartProdRed is
	PORT(
			prod0: in STD_LOGIC_VECTOR(19 downto 0);
			prod1: in STD_LOGIC_VECTOR(20 downto 2);
			prod2: in STD_LOGIC_VECTOR(22 downto 4);
			prod3: in STD_LOGIC_VECTOR(24 downto 6);
			
			prod4: in STD_LOGIC_VECTOR(26 downto 8);
			prod5: in STD_LOGIC_VECTOR(28 downto 10);
			prod6: in STD_LOGIC_VECTOR(30 downto 12);
			prod7: in STD_LOGIC_VECTOR(31 downto 14);
			
			result: out STD_LOGIC_VECTOR(31 downto 0));
end COMPONENT;


SIGNAL aTmp: STD_LOGIC_VECTOR(16 downto 0);
SIGNAL oTmp: STD_LOGIC_VECTOR(31 downto 0);

SIGNAL prod0: STD_LOGIC_VECTOR(19 downto 0);
SIGNAL prod1: STD_LOGIC_VECTOR(18 downto 0);
SIGNAL prod2: STD_LOGIC_VECTOR(18 downto 0);
SIGNAL prod3: STD_LOGIC_VECTOR(18 downto 0);
			
SIGNAL prod4: STD_LOGIC_VECTOR(18 downto 0);
SIGNAL prod5: STD_LOGIC_VECTOR(18 downto 0);
SIGNAL prod6: STD_LOGIC_VECTOR(18 downto 0);
SIGNAL prod7: STD_LOGIC_VECTOR(17 downto 0);

begin
	aTmp <= a & '0';
	
	prod0(19 downto 17) <= (not prod0(16)) & prod0(16) & prod0(16);
	prod1(18 downto 17) <= '1' & (not prod1(16));
	prod2(18 downto 17) <= '1' & (not prod2(16));
	prod3(18 downto 17) <= '1' & (not prod3(16));
	prod4(18 downto 17) <= '1' & (not prod4(16));
	prod5(18 downto 17) <= '1' & (not prod5(16));
	prod6(18 downto 17) <= '1' & (not prod6(16));
	prod7(17) <= not prod7(16);
	
	prodgen0: BoothPartProdGen PORT MAP (
			bin3 => aTmp(2 downto 0),
			a => b,
			product => prod0(16 downto 0)
	);
	
	prodgen1: BoothPartProdGen PORT MAP (
			bin3 => aTmp(4 downto 2),
			a => b,
			product => prod1(16 downto 0)
	);
	
	prodgen2: BoothPartProdGen PORT MAP (
			bin3 => aTmp(6 downto 4),
			a => b,
			product => prod2(16 downto 0)
	);
	
	prodgen3: BoothPartProdGen PORT MAP (
			bin3 => aTmp(8 downto 6),
			a => b,
			product => prod3(16 downto 0)
	);
	
	prodgen4: BoothPartProdGen PORT MAP (
			bin3 => aTmp(10 downto 8),
			a => b,
			product => prod4(16 downto 0)
	);
	
	prodgen5: BoothPartProdGen PORT MAP (
			bin3 => aTmp(12 downto 10),
			a => b,
			product => prod5(16 downto 0)
	);
	
	prodgen6: BoothPartProdGen PORT MAP (
			bin3 => aTmp(14 downto 12),
			a => b,
			product => prod6(16 downto 0)
	);
	
	prodgen7: BoothPartProdGen PORT MAP (
			bin3 => aTmp(16 downto 14),
			a => b,
			product => prod7(16 downto 0)
	);
	
	output: BoothPartProdRed PORT MAP (
			prod0  => prod0,
			prod1  => prod1,
			prod2  => prod2,
			prod3  => prod3,
			prod4  => prod4,
			prod5  => prod5,
			prod6  => prod6,
			prod7  => prod7,
			result => oTmp
	);
	
o <= oTmp(23 downto 8);
			
end Behavioral;