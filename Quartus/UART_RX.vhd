library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


ENTITY UART_RX IS
PORT(
CLK: IN std_logic;
RX_LINE: IN std_logic;
DATA: OUT std_logic_vector (7 downto 0);
BUSY: OUT std_logic
);
END UART_RX;



ARCHITECTURE MAIN OF UART_RX IS
SIGNAL DATAFLL: std_logic_vector (9 downto 0);
SIGNAL RX_FLAG: std_logic:='0';
SIGNAL PRSCL: integer range 0 to 5208:=0;
SIGNAL INDEX: integer range 0 to 9:=0;
BEGIN



PROCESS(CLK)
BEGIN


IF(CLK'EVENT AND CLK='1') THEN
	IF(RX_FLAG='0' AND RX_LINE='0') THEN
		INDEX<=0;
		PRSCL<=0;
		BUSY<='1';
		RX_FLAG<='1';
	END IF;

	IF(RX_FLAG='1') THEN 
		DATAFLL(INDEX)<=RX_LINE;
		IF(PRSCL<5208) THEN
			PRSCL<=PRSCL+1;
		ELSE
			PRSCL<=0;
		END IF;
		IF(PRSCL=2604) THEN
			IF(INDEX<9) THEN
				INDEX<=INDEX+1;
			ELSE
				IF(DATAFLL(0)='0' AND DATAFLL(9)='1') THEN
					DATA<=DATAFLL(8 downto 1);
				ELSE 
				DATA<=(OTHERS=>'0');
				END IF;
			RX_FLAG<='0';
			BUSY<='0';
			END IF;
		END IF;
	END IF;
END IF;
END PROCESS;
END MAIN;