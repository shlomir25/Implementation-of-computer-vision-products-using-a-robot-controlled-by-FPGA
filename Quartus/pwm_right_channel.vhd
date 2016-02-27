library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY pwm_right_channel is
PORT(
CLK: IN std_logic;
PIN_RIGHT: OUT std_logic;
FREQ: IN integer range 0 to 49999;
DUTY: IN integer range 0 to 19
);
END pwm_right_channel;


ARCHITECTURE Behavioral of pwm_right_channel is
SIGNAL temporal: STD_LOGIC:='0';
SIGNAL COUNT: integer range 0 to 49999:=0;
SIGNAL COUNT_IN: integer range 0 to 19:=0;
SIGNAL div_clk: STD_LOGIC:='0';


BEGIN


PROCESS(CLK)
BEGIN

IF(CLK'EVENT AND CLK='1') THEN
	IF(COUNT<FREQ) THEN
		COUNT<=COUNT+1;
	ELSE
		div_clk<=NOT(div_clk);
		COUNT<=0;
	END IF;
END IF;
END PROCESS;



PROCESS(div_clk)
BEGIN

IF(div_clk'EVENT AND div_clk='1') THEN
	IF(COUNT_IN<DUTY) THEN
		temporal<='0';
		COUNT_IN<=COUNT_IN+1;
	ELSE
		temporal<='1';
		COUNT_IN<=0;
	END IF;
END IF;
END PROCESS;

PIN_RIGHT<=temporal;

END;