INCLUDE <P18F4321.INC>; this program uses the PIC18F4321 library and is for adding 3 8-bit numbers 

COUNT EQU 0x10
CARRY EQU 0x12
GOTO MAIN
pADD ORG 0x50
MOVLW 0x2F; 
MOVWF COUNT
MOVF POSTINC1, W
LOOP
MOVF POSTINC1, 0x11
DECF COUNT, F
BCF STATUS, C
BNZ LOOP;Loop around until we get to the parallel address 30 addrs away
ADDWF CARRY, W
ADDWFC POSTINC1, F; store the sum back in high address
MOVF STATUS, W
ANDLW 0x01
MOVWF CARRY;Check for a carry out
RETURN

MAIN ORG 0x100
MOVLW 0xF1
MOVWF 0x20
MOVLW 0x91
MOVWF 0x21
MOVLW 0xB5
MOVWF 0x22
MOVLW 0x07
MOVWF 0x50
MOVLW 0xA2
MOVWF 0x51
MOVLW 0x04
MOVWF 0x52
MOVLW 0x04
MOVWF STKPTR;intialize stkptr

;populate psuedo array with data
BCF STATUS, C
LFSR 1, 0x22
CALL pADD
LFSR 1, 0x21
CALL pADD
LFSR 1, 0x20
CALL pADD
SLEEP
END
