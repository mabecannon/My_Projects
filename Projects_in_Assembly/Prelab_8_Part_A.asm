 INCLUDE <P18F4321.INC>
 ORG 0x00
 CONFIG OSC = INTIO2
 CONFIG WDT = OFF
 CONFIG LVP = OFF
 CONFIG BOR = OFF
 GOTO MAIN_PROG
 
 ORG 0x80 
 MAIN_PROG MOVLW 0x10
 MOVWF 0x10
 BCF TRISD, TRISD1
 MOVLW 0x0F
 MOVWF ADCON1; 0x0F configures INT1 as an input
 BCF INTCON3, INT1IF; Prepare the particular interrupt input
 BSF INTCON3, INT1IE; Enable the particular interrupt system
 BSF INTCON, GIE; Global interrupt enable
 BCF PORTD, RD1; Turn off the LED
 OVER
 BCF PORTD, RD1;
 BRA OVER
 BRA MAIN_PROG

 ORG 8
 RP BSF PORTD, RD1; Turn the LED on (the sweet, sweet service)
 BCF INTCON3, INT1IF;reconfigure interrupt 
 MOVF PORTB, W
 BNZ RP; Repeat the service routine if we are still being interrupted
 RETFIE; return to loop with global interrupt enable reenabled
 END