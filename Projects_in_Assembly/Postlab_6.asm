INCLUDE <P18F4321.INC>


NUM1 EQU 0x10; first 3 bit num
NUM2 EQU 0x11; second 3 bit num

V_0 EQU 0x20
V_1 EQU 0x21
V_2 EQU 0x22
V_3 EQU 0x23
V_4 EQU 0x24
V_5 EQU 0x25
V_6 EQU 0x26
V_7 EQU 0x27
V_8 EQU 0x28
V_9 EQU 0x29; initialize psuedo array without values

MAIN ORG 0x100


MOVLW B'00111111 
MOVWF V_0;XGFEDCBA

MOVLW B'00000110
MOVWF V_1

MOVLW B'01011011
MOVWF V_2

MOVLW B'01001111
MOVWF V_3

MOVLW B'01100110
MOVWF V_4

MOVLW B'01101101
MOVWF V_5

MOVLW B'01111101
MOVWF V_6

MOVLW B'00000111
MOVWF V_7

MOVLW B'01111111
MOVWF V_8

MOVLW B'01101111
MOVWF V_9


CLRF TRISC; let port c be an output to sev seg
SETF TRISD; let port d be an input from dip swt

LFSR 0, 0x20; initialize pointer
 
HERE MOVF PORTD, NUM1;
MOVF PORTD, NUM2; Load unmasked value
MOVF NUM1, W 
ANDLW 0x07;mask off upper 3 bits
MOVWF NUM1;
MOVF NUM2, W
ANDLW 0x38;mask off lower 3 bits
BCF STATUS, C
RRNCF NUM2; reposition bits for addition
RRNCF NUM2;
RRNCF NUM2; Now we have two 3 bit numbers to add together
MOVF NUM2, W
ADDWF NUM1, W
MOVF PLUSW0, PORTC; use the value of NUM1+NUM2 as an index, 
				  ; and output the indexed value to port c
				  ; starting at addr 0x20 = index 0
BRA HERE; loop forever
END
				
