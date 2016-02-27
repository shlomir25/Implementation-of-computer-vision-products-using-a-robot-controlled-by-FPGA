library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY leds is
PORT(
CLK: IN std_logic;
LED_PIN: OUT std_logic_vector (2 downto 0);
LED_VEC: IN std_logic_vector (2 downto 0)
);
END leds;


ARCHITECTURE Behavioral of leds is
SIGNAL pulse: STD_LOGIC:='0';
SIGNAL COUNTER: integer range 0 to 24999999:=0;


BEGIN


PROCESS(CLK)
BEGIN

IF(LED_VEC="000") THEN
	pulse<='0';
ELSE
	IF(CLK'EVENT AND CLK='1') THEN
		IF(COUNTER<24999999) THEN
			COUNTER<=COUNTER+1;
		ELSE
			COUNTER<=0;
			pulse<=NOT(pulse);
		END IF;
	END IF;
END IF;

IF(pulse='0') THEN
	LED_PIN<="000";
ELSE
	LED_PIN<=LED_VEC;
END IF;

END PROCESS;

END;