--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:22:03 04/29/2020
-- Design Name:   
-- Module Name:   C:/work/vhdl/test1/fader_testb.vhd
-- Project Name:  test1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fader
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
 
ENTITY fader_testb IS
END fader_testb;
 
ARCHITECTURE behavior OF fader_testb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fader
    PORT(
         clk : IN  std_logic;
         reset_n : IN  std_logic;
         enable : IN  std_logic;
			count_out : out std_logic_vector(19 downto 0);
			duty : out std_logic_vector(3 downto 0);
         pwm_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset_n : std_logic := '1';
   signal enable : std_logic := '0';

 	--Outputs
   signal pwm_out : std_logic;
	signal count_out : std_logic_vector(19 downto 0);
	signal duty : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fader PORT MAP (
          clk => clk,
          reset_n => reset_n,
          enable => enable,
			 count_out => count_out,
			 duty => duty,
          pwm_out => pwm_out
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		
		wait for clk_period*1000;
		enable <= '1';

      wait;
   end process;

END;
