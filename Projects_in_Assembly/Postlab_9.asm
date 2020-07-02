INCLUDE <P18F4321.INC>
	        CONFIG    OSC=INTIO2; USING THE PROGRAM ON PAGE 254 of 1st edition book
	        CONFIG     WDT=OFF;
	        CONFIG     LVP=OFF;
	        CONFIG     BOR=OFF;
D0 			EQU 	0x30 			; contains data for right (fractional) 7-seg
D1 			EQU 	0x31 			; contains data for left (integer) 7-seg
ADCONRESULT EQU 	0x34 			; contains 8-bit A/D result
			ORG 	0x200 			; starting address of the program
			MOVLW 	0x10 			; Initialize STKPTR to 0x10 (arbitrary value)
			MOVWF 	STKPTR 			; since subroutines are used
			CLRF 	TRISC 			; Configure PortC as output
			CLRF 	TRISD 			; Configure PortD as output
			SETF 	TRISA 			; Configure PortA as input
			MOVLW 	0x01
			MOVWF 	ADCON0 			; Select AN0 for input and enable ADC
			MOVLW 	0x0D
			MOVWF 	ADCON1 			; Select VDD and VSS as reference
			; voltages and AN0 as analog input.
			MOVLW 	0x08
			MOVWF 	ADCON2 			; Select Left justified, 2TAD and Fosc/2
START 		BSF 	ADCON0, GO 		; Start A/D conversion
INCONV 		BTFSS 	ADCON0, DONE 	; Wait until A/D conversion is done
			BRA 	INCONV
			MOVFF 	ADRESH,ADCONRESULT ; Move ADRESH of result
			; into ADCONRESULT register
			CALL 	DIVIDE 			; Call the divide subroutine
			CALL 	DISPLAY 		; Call display subroutine
			BRA 	START
DIVIDE 		CLRF 	D0 				; Clears D0
			CLRF 	D1 				; Clears D1
			MOVLW 	D'51'			; #1 Load 51 into WREG
EVEN		CPFSEQ 	ADCONRESULT 	; #2
			BRA 	QUOTIENT 		; #3
			INCF 	D1, F 			; #4
			SUBWF 	ADCONRESULT, F 	; #5
QUOTIENT	CPFSGT	ADCONRESULT 	; #6 Checks if ADCONRESULT
			 ; still greater than 51
			BRA 	DECIMAL 		; #7
			INCF 	D1, F 			; #8 increment D1 for each time
			 ; ADCONRESULT is greater than 51
			SUBWF 	ADCONRESULT, F 	; #9 Subtract 51 from
			 ; ADCONRESULT
			BRA 	EVEN 			; #10
DECIMAL		MOVLW 	0x05 			; #11
REMAINDER 	CPFSGT 	ADCONRESULT 	; #12 Checks if ADCONRESULT
			 ; greater than 5
			BRA 	DIVDONE 		; #13
			INCF 	D0, F 			; #14 Increment D0 each
			SUBWF 	ADCONRESULT, F 	; #15 Subtract 5
			 ; from ADCONRESULT
			BRA 	REMAINDER
DIVDONE 	RETURN 					; #16
DISPLAY 	MOVFF 	D1, PORTC 		; #17 Output D1 on integer 7-seg
			MOVFF 	D0, PORTD 		; #18 Output D0 on fractional 7-seg
			RETURN
END