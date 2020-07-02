		;Program for the master PIC18F4321 page 266
				INCLUDE <P18F4321.INC>
				ORG 	0x00 			; Reset
				GOTO 	MAIN
				ORG 	0x70
MAIN 			BCF 	TRISC, RC5 		; Configure RC5/SD0 as output
				BCF 	TRISC, RC3 		; Configure RC3/SCK as output
				MOVLW 	0x0F
				MOVWF 	ADCON1 			; Make PORTB digital input
				MOVLW 	5 				; Initialize STKPTR to 5 since subroutine
				MOVWF 	STKPTR 			; called SERIAL_WRITE is used in the program
				MOVLW 	0x40
				MOVWF 	SSPSTAT			; Set data transmission on high to low clock
				MOVLW 	0x20
				MOVWF 	SSPCON1			; Enable serial functions and set to
										; master device, and Fosc/4
GET_DATA 		MOVF 	PORTB,W			; Move switch value to WREG
				CALL 	SERIAL_WRITE 	; Call SERIAL_WRITE function
				BRA 	GET_DATA
SERIAL_WRITE 	MOVWF 	SSPBUF 			; Move switch value to serial buffer
WAIT			BTFSS 	SSPSTAT, BF 	; Wait until transmission is complete
				BRA 	WAIT
				RETURN
				END