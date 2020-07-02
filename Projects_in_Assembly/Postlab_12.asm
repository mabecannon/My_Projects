;Example 11.5 from book
INCLUDE <P18F4321.INC>
			ORG		0x000
			GOTO 	MAIN
			ORG 	0x0008 			; Program will go to CHECK_INT at interrupt
			GOTO 	ADIF_ISR 		; Go to Interrupt Service Routine
			ORG 	0x70 			; Start of the main program
MAIN 		MOVLW 	0x60
			MOVWF 	OSCCON 			; Setting the internal clock to 4MHz
			MOVLW 	0x10 			; Initialize STKPTR
			MOVWF 	STKPTR 			; since interrupt is used
			MOVLW 	0x00
			MOVWF 	TRISC 			; Make PORTC output
			MOVLW 	0x02
			MOVWF 	T2CON 			; Configure Timer2 with prescale 16 and
			 						; no postscale
			CLRF 	TMR2
			BCF 	PIR1, TMR2IF 	; Clears Timer2 flag
			MOVLW 	0x31 			; Use AN12 as ADC
			MOVWF 	ADCON0
			MOVLW 	0x00
			MOVWF 	ADCON1 			; Enable pins for analog input
			MOVLW 	0x08
			MOVWF 	ADCON2 			; 2 TAD and Fosc/2, Left justified
			MOVLW 	0x0C
			MOVWF 	CCP1CON 		; Select PWM mode
			MOVLW 	D'77' 			; Set period of PWM signal
			MOVWF 	PR2
START 		BSF 	ADCON0,GO 		; Start the ADC
WAIT 		BRA 	WAIT 			; Wait for ADC to interrupt
			BRA 	START 			; Start ADC again
			ORG 	0x200 			; start of the Service routine
ADIF_ISR 	MOVFF 	ADRESH, 0x20 	; Move value in ADRESH to 0x20
 									; Divide by 3 using repeated addition
			MOVLW 	0x03 			; Move 3 into the WREG
			CLRF 	0x21 			; Clear value in 0x21
DIVIDE 		CPFSGT 	0x20 			; Compare the value to 3 skip if greater than
			BRA 	FINISHED 		; Division is done
			INCF 	0x21, F 		; Increment 0x21
			SUBWF 	0x20 			; Subtract 3 from 0x20
			BRA 	DIVIDE 			; Subtract again
FINISHED 	MOVFF 	0x21, CCPR1L 	; Move final value into CCPR1L
			BCF 	PIR1, TMR2IF 	; Clear Timer2 flag
			BSF 	T2CON, TMR2ON 	; Turn on Timer2
AGAIN 		BTFSS 	PIR1, TMR2IF 	; Wait until cycle is over
			BRA 	AGAIN
			RETFIE 					; Return to start ADC again
			END