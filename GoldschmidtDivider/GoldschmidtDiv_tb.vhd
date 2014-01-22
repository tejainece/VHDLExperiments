--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:51:11 01/20/2014
-- Design Name:   
-- Module Name:   /home/tejainece/learnings/xilinx/GoldschmidtDiv/GoldschmidtDiv_tb.vhd
-- Project Name:  GoldschmidtDiv
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GoldschmidtDiv
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
 
ENTITY GoldschmidtDiv_tb IS
END GoldschmidtDiv_tb;
 
ARCHITECTURE behavior OF GoldschmidtDiv_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GoldschmidtDivider
	 GENERIC (m: natural := 20);
    PORT(
         N : IN  std_logic_vector(15 downto 0);
         D : IN  std_logic_vector(15 downto 0);
         Q : OUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal N : std_logic_vector(15 downto 0) := (others => '0');
   signal D : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(15 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GoldschmidtDivider GENERIC MAP (m => 20)
	     PORT MAP (
          N => N,
          D => D,
          Q => Q,
          clk => clk,
          reset => reset,
          start => start,
          done => done
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period;
		N(15 downto 8) <= "10000001";
		N(7 downto 0) <= (OTHERS => '0');
		D(15 downto 8) <= "00000111";
		D(7 downto 0) <= (OTHERS => '0');
		start <= '1';
		wait for clk_period;
		start <= '0';

		wait for clk_period*100;
      wait;
   end process;

END;
