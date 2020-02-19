----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:41:50 02/19/2020 
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
    port (SW0, SW1:           in  std_logic;
          BTN0, BTN1:         in  std_logic;
          LD0, LD1, LD2, LD3: out std_logic;
          disp_seg_o:         out std_logic_vector(7-1 downto 0);
          disp_dig_o:         out std_logic_vector(4-1 downto 0));
end entity top;


architecture Behavioral of top is
    signal s_hex: std_logic_vector(4-1 downto 0);   -- Internal signals
begin

    -- Combine inputs [SW1, SW0, BTN1, BTN0] into internal vector
    s_hex(3) <= SW1;
    s_hex(2) <= SW0;
    s_hex(1) <= not BTN1;
    s_hex(0) <= not BTN0;


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    HEX2SSEG: entity work.hex_to_7seg
        port map (-- <entity port_name> => <signal_name>,
                  -- <entity port_name> => <signal_name>,
                  -- ...
                  -- <entity port_name> => <signal_name>);
                  hex_i => s_hex,
                  seg_o => disp_seg_o);

    -- Select display position
    disp_dig_o <= "1110";


    -- Turn on LD3 if the input value is equal to "0000"
     LD3 <= s_hex(3) OR s_hex(2) OR s_hex(1) OR s_hex(0);

    -- Turn on LD2 if the input value is A, B, C, D, E, or F
    LD2 <= (NOT s_hex(2) OR NOT s_hex(3)) AND (NOT s_hex(1) OR NOT s_hex(3));

    -- Turn on LD1 if the input value is odd, ie 1, 2, 3, etc.
    LD1 <= NOT s_hex(0);

    -- Turn on LD0 if the input value is a power of two, ie 1, 2, 4, or 8.
    LD0 <=   '0' when (s_hex = "0001") else   -- 1            
				 '0' when (s_hex = "0010") else   -- 2				 
				 '0' when (s_hex = "0100") else   -- 4 
				 '0' when (s_hex = "1000") else   -- 8
				 '1'; -- neco jineho
end architecture Behavioral;




