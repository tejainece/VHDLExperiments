----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:05 01/29/2014 
-- Design Name: 
-- Module Name:    FloatingPointMul23 - Behavioral 
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

entity FloatingPointMul23 is
	PORT (
		a_in      : in STD_LOGIC_VECTOR(22 downto 0);
		b_in      : in STD_LOGIC_VECTOR(22 downto 0);
		res_out   : out STD_LOGIC_VECTOR(22 downto 0);
		sign	    : out STD_LOGIC;
		zero	    : out STD_LOGIC;
		overflow  : out STD_LOGIC;
		underflow : out STD_LOGIC
	);
end FloatingPointMul23;

architecture Behavioral of FloatingPointMul23 is

COMPONENT Multiply16Booth4 is
	PORT (
		a: IN STD_LOGIC_VECTOR(15 downto 0);
		b: IN STD_LOGIC_VECTOR(15 downto 0);
		o: OUT STD_LOGIC_VECTOR(15 downto 0));
end COMPONENT;

COMPONENT CSA8 is
	 generic (width : integer := 32);
    Port ( a : in  STD_LOGIC_VECTOR (width-1 downto 0);
           b : in  STD_LOGIC_VECTOR (width-1 downto 0);
           o : out  STD_LOGIC_VECTOR (width-1 downto 0);
           cout : out  STD_LOGIC);
end COMPONENT;

SIGNAL tmp_mA : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL tmp_mB : STD_LOGIC_VECTOR(15 downto 0);

SIGNAL mul_t : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL add_t : STD_LOGIC_VECTOR(9 downto 0);
SIGNAL add_t2 : STD_LOGIC_VECTOR(9 downto 0);
SIGNAL bias_normalized : unsigned(9 downto 0);

SIGNAL a_zero : STD_LOGIC;
SIGNAL b_zero : STD_LOGIC;

SIGNAL output : STD_LOGIC_VECTOR(22 downto 0);

CONSTANT C_M127 : unsigned(9 downto 0) := to_unsigned(127, 10);
CONSTANT C_M126 : unsigned(9 downto 0) := to_unsigned(126, 10);

begin

tmp_mA <= "01" & a_in(13 downto 0);
tmp_mB <= "01" & b_in(13 downto 0);
multiplier_i : Multiply16Booth4 PORT MAP (
						a =>tmp_mA,
						b => tmp_mB,
						o => mul_t
					);

exponent_i : CSA8 GENERIC MAP (
						width => 8
					)
					PORT MAP (
						a => a_in(21 downto 14),
						b => b_in(21 downto 14),
						o => add_t(7 downto 0),
						cout => add_t(8)
					);
add_t(9) <= '0';
					
bias_normalized(9 downto 0) <= C_M126 when mul_t(15) = '1' else
                               C_M127;

add_t2 <= std_logic_vector(unsigned(add_t) - bias_normalized);


a_zero <= '1' when a_in(21 downto 0) = "0000000000000000000000" else
			 '0';
b_zero <= '1' when b_in(21 downto 0) = "0000000000000000000000" else
			 '0';

output(13 downto 0) <= "00000000000000" when a_zero = '1' or b_zero = '1'  else
								mul_t(14 downto 1) when mul_t(15) = '1' else
                        mul_t(13 downto 0);
output(21 downto 14) <= "00000000" when a_zero = '1' or b_zero = '1' else
								 add_t2(7 downto 0);
output(22) <= '0' when a_zero = '1' or b_zero = '1' else
					 a_in(22) xor b_in(22);


sign <= a_in(22) xor b_in(22);
zero <= '1' when output(21 downto 0) = "0000000000000000000000" else
		  '0';
overflow  <= '1' when add_t2(9 downto 8) = "01" else
				 '0';
underflow <= '1' when add_t2(9 downto 8) = "11" else
				 '0';
res_out <= output;
end Behavioral;