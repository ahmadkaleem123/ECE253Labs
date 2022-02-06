.global _start
.equ PERIOD, 50000000
.equ TIMER, 0xFFFEC600 
.equ HEX, 0xFF200020
.equ LEDR, 0xFF200000
.equ KEYS, 0xFF200050

_start:
 LDR r2, =HEX
 LDR r5, =TIMER // timer address
 LDR r6, =PERIOD // timer period
 STR r6, [r5] // write to load register
 MOV r6, #0b011 // A - 1, E = 1
 STR r6, [r5, #8]
 LDR r7, =LEDR
 LDR r9, =KEYS
 mov r0, #0
 mov r4, #0 // used for the button press stuff
 BL DISPLAY

 B DELAY
DELAY:	LDR r6, [r5, #0xC] // status reg
	CMP r6, #0 
	BEQ DELAY
STR r6, [r5, #0xC] // write 1 to status reg once done
BL DISPLAY
STR r1, [r7] // write to LEDs
ADD r0, #1 // increment counter
CMP r0, #8
BEQ update
CMP r4, #1 // if it was already pressed
BEQ PRESS_1
B CHECK_KEYS
B DELAY


update: MOV r0, #0
BL DISPLAY
CMP r4, #1 // if it was already pressed
BEQ PRESS_1
B CHECK_KEYS
B DELAY
update_2: 
B DELAY

END: B END

DISPLAY: 
	B check_0
check_0: 
	cmp r0, #0
	BNE check_1
	LDR r1, =ZERONINE
	LDR r1, [r1]
	B DONE
check_1: 
	cmp r0, #1
	BNE check_2
	LDR r1, =ONEEIGHT
	LDR r1, [r1]
	B DONE
check_2: 
	cmp r0, #2
	BNE check_3
	LDR r1, =TWOSEVEN
	LDR r1, [r1]
	B DONE
check_3: 
	cmp r0, #3
	BNE check_4
	LDR r1, =THREESIX
	LDR r1, [r1]
	B DONE
check_4: 
	cmp r0, #4
	BNE check_5
	LDR r1, =FOURFIVE
	LDR r1, [r1]
	B DONE
check_5: // reverse loop 
	cmp r0, #5
	BNE check_6
	LDR r1, =THREESIX
	LDR r1, [r1]
	B DONE
check_6: // reverse loop 
	cmp r0, #6
	BNE check_7
	LDR r1, =TWOSEVEN
	LDR r1, [r1]
	B DONE
check_7: // reverse loop 
	cmp r0, #7
	BNE check_0
	LDR r1, =ONEEIGHT
	LDR r1, [r1]
	B DONE
CHECK_KEYS: 
	LDR r3, [r9] // read keys
	CMP r3, #0x00000008
	BEQ GOBACK // key pressed
	B DELAY

PRESS_1: 
	LDR r3, [r9]
	CMP r3, #0x00000000 // check if released
	BEQ RELEASE_1 // key has been released. Pause code
	B DELAY // keep checking otherwise
RELEASE_1: 
	MOV r4, #0
	LDR r3, [r9]
	CMP r3, #0x00000008 // check for pressed
	BEQ PRESS_2
	B RELEASE_1 // keep waiting for pressed

PRESS_2: 
	LDR r3, [r9]
	CMP r3, #0x00000000
	BEQ update_2 // it has been released
	B PRESS_2 // keep waiting for release

GOBACK: 
	MOV r4, #1
	B DELAY
	
ZERONINE: .word 0b1000000001
ONEEIGHT: .word 0b0100000010
TWOSEVEN: .word 0b0010000100
THREESIX: .word 0b0001001000
FOURFIVE: .word 0b0000110000
DONE: MOV PC, LR
