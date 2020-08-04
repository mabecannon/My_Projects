INCLUDE <P18F4321.INC>; this program will cube a number then divide it by 4, then pushes it onto the stack(pointer)

NUM EQU 0x10
RESULT EQU 0x11

MAIN ORG 0x100
LFSR 0, 0x70
MOVLW 0x02
MOVWF NUM
MOVWF STKPTR; arbitrarily initialize stkptr
CALL MATH_F
MOVFF RESULT, POSTINC0; push value into stkptr
HERE BRA HERE; sleep

MATH_F ORG 0x200
MOVF NUM, W; lets get to work on that number!
MULWF NUM
MOVF PRODL, W;
MULWF NUM
MOVF PRODL, W;
MULWF NUM
MOVF PRODL, W;
MOVWF RESULT
RRNCF RESULT, F
BCF STATUS, C; NO CARRY
RRNCF RESULT, F; divide by 4
RETURN
END
