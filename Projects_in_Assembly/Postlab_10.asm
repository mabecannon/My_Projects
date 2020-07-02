		INCLUDE <P18F4321.INC>
		ORG 	0x100 		; Start of the MAIN program using page 220 of 1st edition book
MAIN 	MOVLW 	0x10 		; Initialize STKPTR with arbitrary value of 0x10
		MOVWF 	STKPTR
		CLRF 	TRISD 		; PORTD is output
		CLRF 	TRISB 		; PORTB is output
		SETF 	TRISC 		; PORTC is input
		CLRF 	PORTB 		; rs=0 rw=0 en=0
		MOVLW 	D'5' 		; 10 ms delay
		CALL 	DELAY
		MOVLW	0x0C 		; Display on, Cursor off
		CALL 	CMD
		MOVLW 	D'5' 		; 10 ms delay
		CALL 	DELAY
		MOVLW 	0x01
		CALL 	CMD 		; Clear Display
		MOVLW 	D'5' 		; 10 ms delay
		CALL 	DELAY
		MOVLW 	0x06 		; Shift Cursor to the right
		MOVLW 	D'5' 		; 10 ms delay
		CALL 	DELAY
		MOVLW 	0x80 		; Move cursor to the start of the first line
		CALL 	CMD
		MOVLW 	D'5' 		; 10 ms delay
		CALL 	DELAY
		MOVLW 	A'S' 		; Send ASCII S
		CALL 	LCDDATA
		MOVLW 	A'w' 		; Send ASCII w
		CALL 	LCDDATA
		MOVLW 	A'i' 		; Send ASCII i
		CALL 	LCDDATA
		MOVLW 	A't' 		; Send ASCII t
		CALL 	LCDDATA
		MOVLW 	A'c' 		; Send ASCII c
		CALL 	LCDDATA
		MOVLW 	A'h' 		; Send ASCII h
		CALL 	LCDDATA
		MOVLW 	A' ' 		; Send ASCII space
		CALL 	LCDDATA
		MOVLW 	A'V' 		; Send ASCII V
		CALL 	LCDDATA
		MOVLW 	A'a' 		; Send ASCII a
		CALL 	LCDDATA
		MOVLW 	A'l' 		; Send ASCII l
		CALL 	LCDDATA
		MOVLW 	A'u' 		; Send ASCII u
		CALL 	LCDDATA
		MOVLW 	A'e' 		; Send ASCII e
		CALL 	LCDDATA
		MOVLW 	A':' 		; Send ASCII :
		CALL 	LCDDATA
AGAIN 	MOVF 	PORTC, W 	; Move switch value to WREG
		ANDLW 	0x0F 		; Mask lower 4 bits
		IORLW 	0x30 		; Convert to ASCII data by ORing with 0x30
		CALL 	LCDDATA 	; Display switch value on screen
		MOVLW 	0x10 		; Shift cursor to left
		CALL 	CMD
		BRA 	AGAIN
CMD 	MOVWF 	PORTD 		; Command is sent to PORTD
		MOVLW 	0x04
		MOVWF 	PORTB 		; rs=0 rw=0 en=1
		MOVLW 	D'5' 		; 10 ms delay
		CALL 	DELAY
		CLRF 	PORTB 		; rs=0 rw=0 en=0
		RETURN
LCDDATA MOVWF 	PORTD 		; Data sent to PORTD
		MOVLW 	0x05 		; rs=1 rw=0 en=1
		MOVWF 	PORTB
		MOVLW 	D'5' 		; 10 ms delay
		CALL 	DELAY
		MOVLW 	0x01
		MOVWF 	PORTB 		; rs=1 rw=0 en=0
		RETURN
DELAY 	MOVWF 	0x20
LOOP1 	MOVLW	D'255' 		; LOOP2 provides 2 ms delay with a count of 255
		MOVWF 	0x21
LOOP2 	DECFSZ 	0X21
		GOTO 	LOOP2
		DECFSZ 	0x20
		GOTO 	LOOP1
		RETURN
		END