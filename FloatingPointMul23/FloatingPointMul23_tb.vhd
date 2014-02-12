--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:24:35 01/29/2014
-- Design Name:   
-- Module Name:   /home/tejainece/learnings/xilinx/FloatingPointMul23/FloatingPointMul23_tb.vhd
-- Project Name:  FloatingPointMul23
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FloatingPointMul23
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FloatingPointMul23_tb IS
END FloatingPointMul23_tb;
 
ARCHITECTURE behavior OF FloatingPointMul23_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FloatingPointMul23
    PORT(
         a_in : IN  std_logic_vector(22 downto 0);
         b_in : IN  std_logic_vector(22 downto 0);
         res_out : OUT  std_logic_vector(22 downto 0);
			sign	    : out STD_LOGIC;
			zero	    : out STD_LOGIC;
			overflow  : out STD_LOGIC;
			underflow : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal a_in : std_logic_vector(22 downto 0) := (others => '0');
   signal b_in : std_logic_vector(22 downto 0) := (others => '0');

 	--Outputs
   signal res_out   : std_logic_vector(22 downto 0);
	signal sign	     : STD_LOGIC;
	signal zero	     : STD_LOGIC;
	signal overflow  : STD_LOGIC;
	signal underflow : STD_LOGIC;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FloatingPointMul23 PORT MAP (
          a_in => a_in,
          b_in => b_in,
          res_out => res_out,
			 sign => sign,
			 zero => zero,
			 overflow => overflow,
			 underflow => underflow
        );

   -- Stimulus process
   stim_proc: process
   begin		
      a_in <= "10000001001100000000000";
		b_in <= "00000000100100000000000";
      wait for 100 ns;	
		a_in <= "11111111101100000000000";
		b_in <= "01111111100100000000000";
      wait for 100 ns;
		a_in <= "11111111101100000000000";
		b_in <= "01111111100000000000000";
      wait for 100 ns;
		a_in <= "10000000000000000000000";
		b_in <= "00000000000000000000000";
      wait for 100 ns;
		a_in <= "11000010000001001000000";
		b_in <= "01000011101111111000000";
      wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
