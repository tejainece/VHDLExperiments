----------------------------------------------------------------------------------
-- Company:  
-- Engineer: 
-- 
-- Create Date:    15:47:26 01/19/2014 
-- Design Name: 
-- Module Name:    GoldschmidtDiv - Behavioral 
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

ENTITY GoldschmidtDivider IS
	GENERIC (m: natural := 20);
	PORT (
		N: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		D: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		Q: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk, reset, start: IN STD_LOGIC;
		done: OUT STD_LOGIC);
END GoldschmidtDivider;

architecture Behavioral of GoldschmidtDivider is

COMPONENT Multiply16Booth4 is
	PORT (
		a: IN STD_LOGIC_VECTOR(15 downto 0);
		b: IN STD_LOGIC_VECTOR(15 downto 0);
		o: OUT STD_LOGIC_VECTOR(15 downto 0));
END COMPONENT;

  TYPE state_type IS (STATE_IDLE, STATE_LOAD, STATE_UPDATE, STATE_DONE); 
  SIGNAL cur_state : state_type; 
  SIGNAL load, update: STD_LOGIC;
  SIGNAL step: NATURAL RANGE 0 TO m-1;
  
  SIGNAL Ni:   STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL Nim1: STD_LOGIC_VECTOR(15 DOWNTO 0);
  
  SIGNAL Di:   STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL Dim1: STD_LOGIC_VECTOR(15 DOWNTO 0);
  
  --SIGNAL F:    STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL Fi:	STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL Fim1:	STD_LOGIC_VECTOR(15 DOWNTO 0);
  
  SIGNAL tDi: STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL tNi: STD_LOGIC_VECTOR(31 DOWNTO 0);
  
  SIGNAL tDone: STD_LOGIC;
  
  constant TWO16: signed := "0000001000000000";

begin
  --intial reciprocal approximation
  --it flips all bits above decimal points
  --F(15 downto 8) <= (OTHERS => '0');
  --F(7 downto 0) <= N(15 downto 8);
  
  --multipliers
  --tDi <= STD_LOGIC_VECTOR(signed(Dim1) * signed(Fim1));
  --tNi <= STD_LOGIC_VECTOR(signed(Nim1) * signed(Fim1));
  
  dmul: Multiply16Booth4 PORT MAP (
    a => Dim1,
    b => Fim1,
    o => tDi(23 downto 8)
  );
  nmul: Multiply16Booth4 PORT MAP (
    a => Nim1,
    b => Fim1,
    o => tNi(23 downto 8)
  );
  
  --Fi calculation
  Fi <= STD_LOGIC_VECTOR(TWO16 - signed(Di));
  
  --internal mux
  Dim1 <= D when load='1' else Di;
  Nim1 <= N when load='1' else Ni;
  --Fim1 <= "00000000" & D(15 downto 8) when load='1' else Fi;
  Fgen: FOR i IN 0 TO 15 GENERATE
    if8to15:IF i >= 8 AND i <= 15 GENERATE
	   Fim1(i) <= '0' when load = '1' else Fi(i);
	 END GENERATE;
	 
	 if0to7:IF i >= 0 AND i <= 7 GENERATE
	   Fim1(i) <= D(i+8) when load = '1' else Fi(i);
	 END GENERATE;
  END GENERATE;
  
  --quotient & output mux
  Q <= Ni when tDone = '1' else (OTHERS => '0');
  done <= tDone;
  
  --di register & rounding
  dregister: PROCESS(clk)
  BEGIN
    IF clk'EVENT and clk = '1' THEN
		IF reset = '1' THEN
		  Di <= (OTHERS => '0');
		ELSIF load = '1' OR update = '1' THEN
		  Di <= tDi(23 downto 8);
		END IF;
    END IF;  
  END PROCESS;

  --ni register & rounding
  nregister: PROCESS(clk)
  BEGIN
    IF clk'EVENT and clk = '1' THEN
	   IF reset = '1' THEN
		  Ni <= (OTHERS => '0');
		ELSIF load = '1' OR update = '1' THEN
		  Ni <= tNi(23 downto 8);
		END IF;
    END IF;  
  END PROCESS;
  
  counter: PROCESS(clk)
  BEGIN
    IF clk'EVENT and clk = '1' THEN
      IF load = '1' THEN step <= 0; 
      ELSIF update = '1' THEN step <= (step+1) MOD m;
      END IF;
    END IF;
  END PROCESS;

  --Controller
  NEXT_STATE_DECODE: PROCESS(clk, reset)
  BEGIN
    IF reset = '1' THEN cur_state <= STATE_IDLE;
    ELSIF clk'EVENT AND clk = '1' THEN
      CASE cur_state IS
        WHEN STATE_IDLE => IF start = '1' THEN cur_state <= STATE_LOAD; END IF;
        WHEN STATE_LOAD => cur_state <= STATE_UPDATE;
        WHEN STATE_UPDATE => IF step = m-1 THEN cur_state <= STATE_DONE; END IF;
		  WHEN STATE_DONE => cur_state <= STATE_IDLE;
      END CASE;
    END IF;
  END PROCESS;

  OUTPUT_DECODE: PROCESS(cur_state)
  BEGIN
    CASE cur_state IS
	   WHEN STATE_IDLE => load <= '0'; update <= '0'; tDone <= '0';
      WHEN STATE_LOAD => load <= '1'; update <= '0'; tDone <= '0';
      WHEN STATE_UPDATE => load <= '0'; update <= '1'; tDone <= '0';
		WHEN STATE_DONE => load <= '0'; update <= '0'; tDone <= '1';
    END CASE;
  END PROCESS;
end Behavioral;
