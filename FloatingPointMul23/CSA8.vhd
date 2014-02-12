----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:38:29 11/20/2013 
-- Design Name: 
-- Module Name:    CSA8 - Behavioral 
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

entity CSA8 is
	 generic (width : integer := 32);
    Port ( a : in  STD_LOGIC_VECTOR (width-1 downto 0);
           b : in  STD_LOGIC_VECTOR (width-1 downto 0);
           o : out  STD_LOGIC_VECTOR (width-1 downto 0);
           cout : out  STD_LOGIC);
end CSA8;

architecture Behavioral of CSA8 is

component HalfAdder 
port ( 	a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			c : out std_logic);
end component;

component ResultGen
port (  a : in  STD_LOGIC;
        b : in  STD_LOGIC;
		  s : out PairT;
		  c : out PairT);
end component;

component Selector
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
end component;

component SelectorLSB
	 generic (
			  num_sum: integer := 0
	 );
    Port ( cIn     : in   PairT;
			  cSel    : in   std_logic;
			  cOut    : out  std_logic;
			  sumIn   : in   PairArr(num_sum downto 0);
			  sumOut  : out  std_logic_vector(num_sum downto 0));
end component;

type PairArrArr is array (natural range <>) of PairArr(width-1 downto 1);

--TODO: reduce msb to log2_ceil(width) - 1 and direct output correctly
signal cSN_LSB : std_logic_vector(log2_ceil(width) downto 0);
signal tempC : PairArrArr(log2_ceil(width) downto 0);
signal tempS : PairArrArr(log2_ceil(width) downto 0);
begin

ha  : HalfAdder port map (a => a(0), b => b(0), s => o(0), c => cSN_LSB(0));

rgN : for index in 1 to (width-1) generate
		begin rg : ResultGen port map (a  => a(index),
								  b  => b(index),
								  s  => tempS(0)(index),
								  c  => tempC(0)(index));
		end generate;

selStage: for stage in 0 to log2_ceil(width) - 1 generate
	constant slice : integer  := 2**(stage+1);
	constant sInTot : integer := 2**(stage);
	constant sels : integer   := width/slice;
begin
	selSel: for index in 0 to (width/slice)-1 generate
		constant msb : integer    := (slice*(index+1))-1;
		constant lsb : integer    := (slice*index);
		constant sInLSB : integer := msb-sInTot+1;
		constant bInMSB : integer := msb-sInTot;
		constant bInTot : integer := bInMSB-lsb+1;
	begin
		selIf0: if index = 0 generate
			selB0: SelectorLSB generic map ( num_sum => sInTot - 1)
				port map    ( cIn     => tempC(stage)(msb),
						  cSel    => cSN_LSB(stage),
						  cOut    => cSN_LSB(stage+1),
						  sumIn   => tempS(stage)(msb downto sInLSB),
						  sumOut  => o(msb downto sInLSB));
		end generate;
						  
		selIfN: if index /= 0 generate
			constant csel : integer   := msb - sInTot;
		begin
			selBN: Selector generic map ( num_sum => sInTot - 1, num_buffer => bInTot - 1)
				port map    ( cIn     => tempC(stage)(msb),
						  cSel      => tempC(stage)(csel),
						  cOut      => tempC(stage+1)(msb),
						  sumIn     => tempS(stage)(msb downto sInLSB),
						  sumOut    => tempS(stage+1)(msb downto sInLSB),
						  bufferIn  => tempS(stage)(bInMSB downto lsb),
						  bufferOut => tempS(stage+1)(bInMSB downto lsb));
		end generate;
	end generate;
end generate;

cout <= cSN_LSB(log2_ceil(width));

end Behavioral;