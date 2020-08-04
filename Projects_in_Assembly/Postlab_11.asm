			INCLUDE <P18F4321.INC>;This program is for creating PWM signals on the PIC18F using Capture and Compare Module 1 and Timer 3
			ORG 	0x100 		
MAIN 		MOVLW 	0x02
			MOVWF 	CCP1CON	; Select compare mode, toggle CCP1 pin on match
			BCF		TRISC,TRISC2 ; make port RC2 an output for sending PWM 
			MOVLW	0x40 ; Select TIMER3 as clock for compare, 1:1 prescale
			MOVWF	T3CON ; The values will be the same using the calculations from prelab/lab 
			
LOOP 		MOVLW	0x18			 
			MOVWF	CCPR1H 			 
			MOVLW	0x6A			 
			MOVWF	CCPR1L ; TMR3 will count and CCP will interrupt when the values are the same
			CLRF	TMR3H ; Initialize TMR3H to 0
			CLRF	TMR3L ; Initialize TMR3L to 0
			BCF		PIR1, CCP1IF ; Clear CCP1IF
			BSF		T3CON, TMR3ON ; Start TIMER3
LOW_DUTY	BTFSS	PIR1, CCP1IF ; Wait in Loop until interrupt
			BRA		LOW_DUTY		
			BCF		T3CON,TMR3ON ; Stop Timer, high duty cycle now	
			MOVLW	0x49 
			MOVWF	CCPR1H  
			MOVLW	0x3E			
			MOVWF	CCPR1L			
			CLRF	TMR3H			
			CLRF	TMR3L			
			BCF		PIR1, CCP1IF ; Reset interrupt
			BSF		T3CON, TMR3ON ; Start Timer
HIGH_DUTY	BTFSS	PIR1, CCP1IF ; Wait for interrupt
			BRA		HIGH_DUTY		;
			BCF		T3CON,TMR3ON	; Stop Timer3
			BRA 	LOOP			; Go back to low
			END
