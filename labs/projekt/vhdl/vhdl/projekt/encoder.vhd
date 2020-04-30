----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:21:15 04/30/2020 
-- Design Name: 
-- Module Name:    encoder - Behavioral 
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

entity encoder is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
			  rotary_q1 : in STD_LOGIC;
			  rotary_q2 : in STD_LOGIC;
			  counter : out INTEGER RANGE 0 to 1000
			  );
end encoder;

architecture Behavioral of encoder is

SIGNAL counter_tmp : INTEGER RANGE 0 TO 1000 := 0; 
SIGNAL delay_rotary_q1 : STD_LOGIC := '0';
SIGNAL rotary_event : STD_LOGIC := '0';
SIGNAL rotary_left : STD_LOGIC := '0';

begin

counter <= counter_tmp;

direction: process(clk)
  begin
  if clk'event and clk='1' then
    if(reset_n = '0') then
      counter <= 0;
    else
      delay_rotary_q1 <= rotary_q1;
      if rotary_q1='1' and delay_rotary_q1='0' then
        rotary_event <= '1';
        rotary_left <= rotary_q2;
		  if(rotary_q2 = '1') then --Tocime doleva- ubirame cas
		    if(counter_tmp > 0) then
			   counter_tmp <= counter_tmp - 1;
		    end if;
		  else
		    if(counter_tmp < 1000) then
		      counter_tmp <= counter_tmp + 1;
			 end if;
		  end if;
			  
      else
        rotary_event <= '0';
        rotary_left <= rotary_left;
      end if;
    end if;
  end if;
end process direction;

end Behavioral;


