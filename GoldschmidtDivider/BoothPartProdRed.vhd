----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:29:03 01/16/2014 
-- Design Name: 
-- Module Name:    BoothPartProdRed - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BoothPartProdRed is
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
end BoothPartProdRed;

architecture Behavioral of BoothPartProdRed is

COMPONENT HAdder is
	port( a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			c : out std_logic);
END COMPONENT;

COMPONENT  FAdder is
	Port ( a : in STD_LOGIC;
			 b : in STD_LOGIC;
			 c : in STD_LOGIC;
			 s : out STD_LOGIC;
			 co : out STD_LOGIC);
END COMPONENT;

COMPONENT Counter4_2 is
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
END COMPONENT;

SIGNAL tempS1: STD_LOGIC_VECTOR(24 downto 2);
SIGNAL tempC1: STD_LOGIC_VECTOR(23 downto 3);
SIGNAL ctemp1: STD_LOGIC_VECTOR(21 downto 7);

SIGNAL tempS2: STD_LOGIC_VECTOR(31 downto 8);
SIGNAL tempC2: STD_LOGIC_VECTOR(31 downto 11);
SIGNAL ctemp2: STD_LOGIC_VECTOR(31 downto 8);

SIGNAL tempS3: STD_LOGIC_VECTOR(31 downto 3);
SIGNAL tempC3: STD_LOGIC_VECTOR(32 downto 4);
SIGNAL ctemp3: STD_LOGIC_VECTOR(25 downto 12);

begin

result(1 downto 0) <= prod0(1 downto 0);
result(2) <= tempS1(2);
tempS2(9 downto 8) <= prod4(9 downto 8);

tempS1(24 downto 23) <= prod3(24 downto 23);
tempS2(31) <= prod7(31);

result(3) <= tempS3(3);

result(31 downto 4) <= std_logic_vector(unsigned(tempS3(31 downto 4)) + unsigned(tempC3(31 downto 4)));

mainfor: FOR index in 2 to 31 GENERATE

	if1_2to3:IF index >= 2 and index <= 3 GENERATE
		SUM_BIT2: HAdder PORT MAP (
							a=>prod0(index),
							b=>prod1(index),
							s=>tempS1(index),
							c=>tempC1(index+1));
	END GENERATE;
	
	if1_4to5:IF index >= 4 and index <= 5 GENERATE
		SUM_BIT4: FAdder PORT MAP (
							a=>prod0(index), 
							b=>prod1(index), 
							c=>prod2(index),
							s=>tempS1(index),
							co=>tempC1(index+1));
	END GENERATE;
	
	if1_6:IF index = 6 GENERATE
		SUM6to19: Counter4_2 PORT MAP (
							a => prod0(index),
							b => prod1(index),
							c => prod2(index),
							d => prod3(index),
		
							tin => '0',
		
							s => tempS1(index),
							co => tempC1(index+1),
		
							tout => ctemp1(index+1));
	END GENERATE; 
	
	if1_7tp19:IF index >= 7 and index <= 19 GENERATE
		SUM7to19: Counter4_2 PORT MAP (
							a => prod0(index),
							b => prod1(index),
							c => prod2(index),
							d => prod3(index),
		
							tin => ctemp1(index),
		
							s => tempS1(index),
							co => tempC1(index+1),
		
							tout => ctemp1(index+1));
	END GENERATE;
	
	if1_20:IF index = 20 GENERATE
		SUM6to19: Counter4_2 PORT MAP (
							a => '0',
							b => prod1(index),
							c => prod2(index),
							d => prod3(index),
		
							tin => ctemp1(index),
		
							s => tempS1(index),
							co => tempC1(index+1),
		
							tout => ctemp1(index+1));
	END GENERATE;
	
	if1_21:IF index = 21 GENERATE
		SUM_BIT4: FAdder PORT MAP (
							a=>ctemp1(index), 
							b=>prod2(index), 
							c=>prod3(index),
							s=>tempS1(index),
							co=>tempC1(index+1));
	END GENERATE;
	
	if1_22:IF index = 22 GENERATE
		SUM_BIT2: HAdder PORT MAP (
							a=>prod2(index),
							b=>prod3(index),
							s=>tempS1(index),
							c=>tempC1(index+1));
	END GENERATE;
	
	
	
	
	
	if1_10to11:IF index >= 10 and index <= 11 GENERATE
		SUM_BIT2: HAdder PORT MAP (
							a=>prod4(index),
							b=>prod5(index),
							s=>tempS2(index),
							c=>tempC2(index+1));
	END GENERATE;
	
	if1_12to13:IF index >= 12 and index <= 13 GENERATE
		SUM_BIT4: FAdder PORT MAP (
							a=>prod4(index), 
							b=>prod5(index), 
							c=>prod6(index),
							s=>tempS2(index),
							co=>tempC2(index+1));
	END GENERATE;

	if1_14:IF index = 14 GENERATE
		SUM6to19: Counter4_2 PORT MAP (
							a => prod4(index),
							b => prod5(index),
							c => prod6(index),
							d => prod7(index),
		
							tin => '0',
		
							s => tempS2(index),
							co => tempC2(index+1),
		
							tout => ctemp2(index+1));
	END GENERATE; 
	
	if1_15to26:IF index >= 15 and index <= 26 GENERATE
		SUM7to19: Counter4_2 PORT MAP (
							a => prod4(index),
							b => prod5(index),
							c => prod6(index),
							d => prod7(index),
		
							tin => ctemp2(index),
		
							s => tempS2(index),
							co => tempC2(index+1),
		
							tout => ctemp2(index+1));
	END GENERATE;
	
	if1_27to28:IF index >= 27 and index <= 28 GENERATE
		SUM6to19: Counter4_2 PORT MAP (
							a => '0',
							b => prod5(index),
							c => prod6(index),
							d => prod7(index),
		
							tin => ctemp2(index),
		
							s => tempS2(index),
							co => tempC2(index+1),
		
							tout => ctemp2(index+1));
	END GENERATE;
	
	if1_29:IF index = 29 GENERATE
		SUM_BIT4: FAdder PORT MAP (
							a=>ctemp2(index), 
							b=>prod6(index), 
							c=>prod7(index),
							s=>tempS2(index),
							co=>tempC2(index+1));
	END GENERATE;
	
	if1_30:IF index = 30 GENERATE
		SUM_BIT2: HAdder PORT MAP (
							a=>prod6(index),
							b=>prod7(index),
							s=>tempS2(index),
							c=>tempC2(index+1));
	END GENERATE;
	
	
	
	
	if2_3to7:IF index >= 3 and index <= 7 GENERATE
		SUM_BIT2: HAdder PORT MAP (
							a=>tempS1(index),
							b=>tempC1(index),
							s=>tempS3(index),
							c=>tempC3(index+1));
	END GENERATE;
	
	if2_8to10:IF index >= 8 and index <= 10 GENERATE
		SUM_BIT4: FAdder PORT MAP (
							a=>tempS1(index), 
							b=>tempC1(index), 
							c=>tempS2(index),
							s=>tempS3(index),
							co=>tempC3(index+1));
	END GENERATE;
	
	if2_11:IF index = 11 GENERATE
		SUM6to19: Counter4_2 PORT MAP (
							a => tempS1(index),
							b => tempC1(index),
							c => tempS2(index),
							d => tempC2(index),
		
							tin => '0',
		
							s =>  tempS3(index),
							co => tempC3(index+1),
		
							tout => ctemp3(index+1));
	END GENERATE; 
	
	if2_12to23:IF index >= 12 and index <= 23 GENERATE
		SUM7to19: Counter4_2 PORT MAP (
							a => tempS1(index),
							b => tempC1(index),
							c => tempS2(index),
							d => tempC2(index),
		
							tin => ctemp3(index),
		
							s => tempS3(index),
							co => tempC3(index+1),
		
							tout => ctemp3(index+1));
	END GENERATE;
	
	if2_24:IF index = 24 GENERATE
		SUM6to19: Counter4_2 PORT MAP (
							a => tempS1(index),
							b => '0',
							c => tempS2(index),
							d => tempC2(index),
		
							tin => ctemp3(index),
		
							s => tempS3(index),
							co => tempC3(index+1),
		
							tout => ctemp3(index+1));
	END GENERATE;
	
	if2_25:IF index = 25 GENERATE
		SUM_BIT4: FAdder PORT MAP (
							a=>ctemp3(index), 
							b=>tempS2(index), 
							c=>tempC2(index),
							s=>tempS3(index),
							co=>tempC3(index+1));
	END GENERATE;
	
	if2_26to31:IF index >= 26 and index <= 31 GENERATE
		SUM_BIT2: HAdder PORT MAP (
							a=>tempS2(index),
							b=>tempC2(index),
							s=>tempS3(index),
							c=>tempC3(index+1));
	END GENERATE;
END GENERATE;

end Behavioral;