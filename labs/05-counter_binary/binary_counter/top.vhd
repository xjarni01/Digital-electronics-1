----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:00:31 03/04/2020 
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
library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port (
    clk_i      : in  std_logic;     -- 10 kHz clock signal
    BTN0       : in  std_logic;     -- Synchronous reset
    disp_seg_o : out std_logic_vector(7-1 downto 0);
    disp_dig_o : out std_logic_vector(4-1 downto 0)
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    constant c_NBIT0 : positive := 4;   -- Number of bits for Counter0
			signal s_en : std_logic;
			signal s_hex : std_logic_vector(4-1 downto 0);
begin

    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity
     CLK_EN_0 : entity work.clock_enable
	 generic map (g_NPERIOD => x"09C4")
	 port map (
		 clk_i	=>	clk_i,
		 srst_n_i => BTN0,
		 clock_enable_o => s_en);

    --------------------------------------------------------------------
    -- Sub-block of binary_cnt entity
	 BIN_CNT_0 : entity work.binary_cnt
	 generic map (g_NBIT => 4	 )
	 port map (
		 clk_i   => clk_i,   -- 10 kHz
		 en_i => s_en,
		 srst_n_i => BTN0,
		 cnt_o   => s_hex);


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    hex_to_7seg : entity work.hex_to_7seg
	 port map (hex_i => s_hex, 
		 seg_o => disp_seg_o);
	 
	 

  
    disp_dig_o <= "1110";

end architecture Behavioral;