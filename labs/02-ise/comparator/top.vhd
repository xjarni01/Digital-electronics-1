----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:22:15 02/12/2020 
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
		port (BTN1, BTN0:    in  std_logic;
          LD2, LD1, LD0: out std_logic);
end top;

architecture Behavioral of top is
begin
    LD2 <= BTN0 and (not BTN1) ;
    LD1 <= (BTN0 and BTN1) or ((not BTN0) and  (not BTN1));
    LD0 <= (BTN0 or BTN1) and ((not BTN0) or BTN1) and ((not BTN0) or  (not BTN1));
	
end architecture Behavioral;

