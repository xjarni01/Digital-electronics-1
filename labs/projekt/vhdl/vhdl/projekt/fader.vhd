library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fader is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  count_out : out std_logic_vector(19 downto 0);
			  duty : out std_logic_vector(3 downto 0);
			  pwm_out : out std_logic);
end fader;

architecture Behavioral of fader is

COMPONENT pwm
    PORT(
         clk : IN  std_logic;
         reset_n : IN  std_logic;
         ena : IN  std_logic;
         duty : in  std_logic_vector(3 downto 0);
         pwm_out : OUT  std_logic
        );
    END COMPONENT;

-- Pro jemny prechod - perioda PWM * konstanta 

   signal ena : std_logic := '1';
	signal pwm_out_tmp : std_logic := '0';
   signal duty_tmp : std_logic_vector(3 downto 0) := (OTHERS => '1');
	CONSTANT count_min  : std_logic_vector(count_out'range) := (OTHERS => '0');    
	signal count : std_logic_vector(count_out'range) := (OTHERS => '1'); -- zhruba 1.04s pri 1MHz clock 
begin

   pwm_module: pwm PORT MAP (
          clk => clk,
          reset_n => reset_n,
          ena => ena,
          duty => duty_tmp,
          pwm_out => pwm_out_tmp
        );

count_out <= count;	
duty_tmp <= count(19 downto 16);
duty <= duty_tmp;	
pwm_out <= pwm_out_tmp when enable = '1' else '1';

  PROCESS(clk)
  BEGIN
  IF rising_edge(clk) THEN
	IF(reset_n = '0') THEN		--synchronous reset
		count <= (OTHERS => '1');
		--duty_tmp <= (OTHERS => '1');
	end if;
	
	IF(count = count_min) THEN
		-- Proste se tady zasekni a je hotovo. Jen reset nas zachrani
		--count <= (OTHERS => 0);
	ELSIF(enable = '1') THEN
		count <= count - 1;
	END IF;
   END IF;
	END PROCESS;
end Behavioral;

