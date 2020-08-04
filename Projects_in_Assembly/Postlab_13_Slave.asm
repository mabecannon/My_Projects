
		INCLUDE <P18F4321.INC>; this copde sets the PIC18F4321 to be an SPI slave in a master-slave network
		ORG 	0x00 			; Reset
		GOTO 	MAIN
		ORG 	0x100
MAIN 	BSF 	TRISC, RC4 		; Configure RC4/SDI as input
		BSF 	TRISC, RC3 		; Configure RC3/SCK as input
		CLRF 	TRISD 			; Configure PORTD as output
		MOVLW 	0x40	
		MOVWF 	SSPSTAT 		; Set data transmission on high to
								; low clock
		MOVLW 	0x25
		MOVWF 	SSPCON1 		; Enable serial functions and
								; set to the slave
WAIT 	BTFSS 	SSPSTAT, BF 	; Wait until transmission is
								; complete (BF=1)
		BRA 	WAIT 			; If BF=0, wait
		MOVFF 	SSPBUF, PORTD 	; Output serial buffer data to
								; PORTD LEDs
		BRA 	WAIT
		END
