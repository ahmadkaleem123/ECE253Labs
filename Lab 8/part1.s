.text
	.global ONES

ONES:
	MOV R0, #0
	B LOOP

LOOP:
	CMP R1, #0 			// If R1 is 0, end the loop 
	BEQ ENDSUB
	LSR R2, R1, #1 		// Otherwise, perform SHIFT and AND
	AND R1, R1, R2
	ADD R0, #1			// Adds 1 to the counter
	B 	LOOP
	
ENDSUB:
	MOV PC, LR			// Ends the subroutine