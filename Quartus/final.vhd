library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



ENTITY final IS
PORT(
CLOCK_50: IN std_logic;
LED: OUT std_logic_vector (7 downto 0);
GPIO_0: IN std_logic_vector (5 downto 4);
GPIO_1: OUT std_logic_vector (6 downto 1)
);
END final;



ARCHITECTURE MAIN OF final IS
SIGNAL RX_DATA: std_logic_vector(7 downto 0);
SIGNAL RX_BUSY: std_logic;
SIGNAL FREQ_RIGHT: integer range 0 to 49999;
SIGNAL FREQ_LEFT: integer range 0 to 49999;
SIGNAL DUTY_RIGHT: integer range 0 to 19;
SIGNAL DUTY_LEFT: integer range 0 to 19;
SIGNAL COLOR_VEC: std_logic_vector(2 downto 0);



COMPONENT UART_RX IS
PORT(
CLK: IN std_logic;
RX_LINE: IN std_logic;
DATA: OUT std_logic_vector (7 downto 0);
BUSY: OUT std_logic
);
END COMPONENT UART_RX;



COMPONENT pwm_right_channel IS
PORT(
CLK: IN std_logic;
PIN_RIGHT: OUT std_logic;
FREQ: IN integer range 0 to 49999;
DUTY: IN integer range 0 to 19
);
END COMPONENT pwm_right_channel;


COMPONENT pwm_left_channel is
PORT(
CLK: IN std_logic;
PIN_LEFT: OUT std_logic;
FREQ: IN integer range 0 to 49999;
DUTY: IN integer range 0 to 19
);
END COMPONENT pwm_left_channel;


COMPONENT leds is
PORT(
CLK: IN std_logic;
LED_PIN: OUT std_logic_vector (2 downto 0);
LED_VEC: IN std_logic_vector (2 downto 0)
);
END COMPONENT leds;



BEGIN

C1: UART_RX PORT MAP(CLOCK_50,GPIO_0(4),RX_DATA,RX_BUSY);
C2: pwm_right_channel PORT MAP(CLOCK_50,GPIO_1(1),FREQ_RIGHT,DUTY_RIGHT);
C3: pwm_left_channel PORT MAP(CLOCK_50,GPIO_1(2),FREQ_LEFT,DUTY_LEFT);
C4: leds PORT MAP(CLOCK_50,GPIO_1(6 downto 4),COLOR_VEC);



PROCESS(RX_BUSY)
BEGIN

IF(RX_BUSY'EVENT AND RX_BUSY='0') THEN
	LED(7 downto 0)<=RX_DATA;
END IF;

CASE RX_DATA is

	WHEN "01110010"=>       --right
		FREQ_RIGHT<=37499;
		DUTY_RIGHT<=12;
		FREQ_LEFT<=24999;
		DUTY_LEFT<=19;
		COLOR_VEC<="000";

	WHEN "01101100"=>       --left
		FREQ_RIGHT<=49999;
		DUTY_RIGHT<=9;
		FREQ_LEFT<=37499;
		DUTY_LEFT<=12;
		COLOR_VEC<="000";
		
	WHEN "01100110"=>       --up
		FREQ_RIGHT<=49999;
		DUTY_RIGHT<=9;
		FREQ_LEFT<=24999;
		DUTY_LEFT<=19;
		COLOR_VEC<="000";
	

	WHEN "01100010"=>       --down
		FREQ_RIGHT<=24999;
		DUTY_RIGHT<=19;
		FREQ_LEFT<=49999;
		DUTY_LEFT<=9;
		COLOR_VEC<="000";
		
	WHEN "01011001"=>       --yellow
		FREQ_RIGHT<=37499;
		DUTY_RIGHT<=12;
		FREQ_LEFT<=37499;
		DUTY_LEFT<=12;
		COLOR_VEC<="001";
		
	WHEN "01010010"=>       --red
		FREQ_RIGHT<=37499;
		DUTY_RIGHT<=12;
		FREQ_LEFT<=37499;
		DUTY_LEFT<=12;
		COLOR_VEC<="010";
		
	WHEN "01000111"=>       --green
		FREQ_RIGHT<=37499;
		DUTY_RIGHT<=12;
		FREQ_LEFT<=37499;
		DUTY_LEFT<=12;
		COLOR_VEC<="100";
		
	WHEN others=>           --others
		FREQ_RIGHT<=37499;
		DUTY_RIGHT<=12;
		FREQ_LEFT<=37499;
		DUTY_LEFT<=12;
		COLOR_VEC<="000";
		
END CASE;

END PROCESS;

GPIO_1(3) <='0';

END MAIN;





