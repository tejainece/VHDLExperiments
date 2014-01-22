--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:08:56 01/16/2014
-- Design Name:   
-- Module Name:   /home/tejainece/learnings/xilinx/BoothPartProdGen/BoothPartProdGen_tb.vhd
-- Project Name:  BoothPartProdGen
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BoothPartProdGen
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
 
ENTITY BoothPartProdGen_tb IS
END BoothPartProdGen_tb;
 
ARCHITECTURE behavior OF BoothPartProdGen_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BoothPartProdGen
    PORT(
         bin3 : IN  std_logic_vector(2 downto 0);
         a : IN  std_logic_vector(15 downto 0);
         product : OUT  std_logic_vector(16 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal bin3 : std_logic_vector(2 downto 0) := (others => '0');
   signal a : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal product : std_logic_vector(16 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BoothPartProdGen PORT MAP (
          bin3 => bin3,
          a => a,
          product => product
        );

	stim_proc: process
	begin         
		a <= "0000000000000101";
		bin3 <= "000";
		wait for 10 ns;
		bin3 <= "001";
		wait for 10 ns;
		bin3 <= "010";
		wait for 10 ns;
		bin3 <= "011";
		wait for 10 ns;
		bin3 <= "100";
		wait for 10 ns;
		bin3 <= "101";
		wait for 10 ns;
		bin3 <= "110";
		wait for 10 ns;
		bin3 <= "111";
		wait for 10 ns;
		wait;
  end process;

END;
