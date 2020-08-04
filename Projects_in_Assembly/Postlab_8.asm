		INCLUDE <P18F4321.INC>;This program is serves an introduction into interrupts, turning on an LED output when a comparator input is turned on.
		CONFIG	OSC=INTIO2;
		CONFIG 	WDT=OFF;
		CONFIG 	LVP=OFF;
		CONFIG 	BOR=OFF;		

MAIN	ORG		0x150			
		MOVLW	0x0F; Port b is digital input
		MOVWF	ADCON1
		CLRF	TRISA; Port a is an output			
		BSF		INTCON,INT0IE	
		BCF		INTCON,INT0IF	
		BSF		INTCON,GIE; interrupt setup		
LOOP	BCF		PORTA,RA3; turn off LED until interrupt		
		BRA		LOOP			
		

		ORG		0X08; INTERRUPT
STILL 	CALL	ISR
		MOVF PORTB, W; while PORTB is still interrupting, keep servicing
		BNZ STILL
		RETFIE

ISR		ORG		0x200; INTERRUPT SERVICE ROUTINE 
	 	BSF 	PORTC, RC1 		
		BCF 	INTCON, INT1IF 	
		RETURN			
		END
