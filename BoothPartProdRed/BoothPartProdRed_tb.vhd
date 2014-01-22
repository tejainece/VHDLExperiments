--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:08:01 01/21/2014
-- Design Name:   
-- Module Name:   /home/tejainece/learnings/xilinx/BoothPartProdRed/BoothPartProdRed_tb.vhd
-- Project Name:  BoothPartProdRed
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BoothPartProdRed
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
 
ENTITY BoothPartProdRed_tb IS
END BoothPartProdRed_tb;
 
ARCHITECTURE behavior OF BoothPartProdRed_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BoothPartProdRed
    PORT(
         prod0 : IN  std_logic_vector(19 downto 0);
         prod1 : IN  std_logic_vector(20 downto 2);
         prod2 : IN  std_logic_vector(22 downto 4);
         prod3 : IN  std_logic_vector(24 downto 6);
         prod4 : IN  std_logic_vector(26 downto 8);
         prod5 : IN  std_logic_vector(28 downto 10);
         prod6 : IN  std_logic_vector(30 downto 12);
         prod7 : IN  std_logic_vector(31 downto 14);
         result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal prod0 : std_logic_vector(19 downto 0) := (others => '0');
   signal prod1 : std_logic_vector(20 downto 2) := (others => '0');
   signal prod2 : std_logic_vector(22 downto 4) := (others => '0');
   signal prod3 : std_logic_vector(24 downto 6) := (others => '0');
   signal prod4 : std_logic_vector(26 downto 8) := (others => '0');
   signal prod5 : std_logic_vector(28 downto 10) := (others => '0');
   signal prod6 : std_logic_vector(30 downto 12) := (others => '0');
   signal prod7 : std_logic_vector(31 downto 14) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BoothPartProdRed PORT MAP (
          prod0 => prod0,
          prod1 => prod1,
          prod2 => prod2,
          prod3 => prod3,
          prod4 => prod4,
          prod5 => prod5,
          prod6 => prod6,
          prod7 => prod7,
          result => result
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		prod0 <= "11111111111111111111";
		prod1 <= "1111111111111111111";
		prod2 <= "0000000000000000001";
		prod3 <= "1111111111111111111";
		prod4 <= "0000000000000000001";
		prod5 <= "0000000000000000001";
		prod6 <= "0000000000000000001";
		prod7 <= "000000000000000001";
      wait for 100 ns;	

      wait for 100 ns;

      wait;
   end process;

END;
