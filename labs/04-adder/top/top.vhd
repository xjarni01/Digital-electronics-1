----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:53:58 02/26/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    port (SW0_CPLD:   in  std_logic;        -- Input A
          SW1_CPLD:   in  std_logic;
          SW2_CPLD:   in  std_logic;
          SW3_CPLD:   in  std_logic;
          SW8_CPLD:   in  std_logic;        -- Input B
          SW9_CPLD:   in  std_logic;
          SW10_CPLD:  in  std_logic;
          SW11_CPLD:  in  std_logic;
          disp_seg_o: out std_logic_vector(7-1 downto 0);
          disp_dig_o: out std_logic_vector(4-1 downto 0));
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_dataA, s_dataB: std_logic_vector(4-1 downto 0);
    signal s_carry0, s_carry1, s_carry2: std_logic;
    signal s_result: std_logic_vector(4-1 downto 0);
    signal s_carryOut: std_logic;
begin

    -- Combine two 4-bit inputs to internal signals s_dataA and s_dataB
		


    --------------------------------------------------------------------
    -- Sub-blocks of four full_adders
    FULLADDER0: entity work.full_adder
        port map (a_i <= s_dataA(0),
						b_i <= s_dataB(0),
						carry_i <= '0',
						sum <= s_result(0),
						carry_o <= s_carry0);

    FULLADDER1: entity work.full_adder
        port map (carry_i <= s_carry0,
						a_i <= s_dataA(1),
						b_i <= s_dataB(1),
						sum <= s_result(1),
						carry_o <= s_carry1);

    FULLADDER2: entity work.full_adder
        port map (carry_i <= s_carry1,
						a_i <= s_dataA(2),
						b_i <= s_dataB(2),
						sum <= s_result(2),
						carry_o <= s_carry2);

    FULLADDER3: entity work.full_adder
        port map (carry_i <= s_carry2,
						a_i <= s_dataA(3),
						b_i <= s_dataB(3),
						sum <= s_result(3));


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    HEX2SSEG: entity work.hex_to_7seg
        port map (
                  hex_i <= s_result,
						seg_o <= disp_seg_o);

    -- Select display position
    disp_dig_o <= "1110";


    -- Show carry output bit on Coolrunner-II LED
    -- WRITE YOUR CODE HERE

    -- Show two 4-bit inputs on CPLD expansion LEDs
    -- WRITE YOUR CODE HERE

end architecture Behavioral;