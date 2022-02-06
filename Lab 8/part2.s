.global _start
.global SWAP
//LIST: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33

_start:
	LDR R2, =LIST // load list
	LDR R1, [R2] 
	LDR R6, [R2]
	MOV R7, #0 // number of elements in the loop
	MOV R0, #0
	
OUTER_LOOP: 
	CMP R7, R6
	BEQ END
	ADD R7, R7, #1
	MOV R8, #1
	MOV R9, R2 // current position in the array
	B INNER_LOOP 
	
INNER_LOOP:
	CMP R8, R6
	BEQ OUTER_LOOP 
	ADD R8, R8, #1 // increase counter
	ADD R9, R9, #4
	MOV R0, R9
	BL SWAP 
	B INNER_LOOP 
	

SWAP: 
	PUSH {R2, R4, R5, LR}
	LDR R4, [R0]
	LDR R5, [R0, #4]
	CMP R4, R5
	BGT DOSWAP
	B DONOTSWAP
	

DOSWAP: 
	STR R5, [R0] // move R5 < R4 into original position of R4.
	STR R4, [R0, #4] // move R4 > R5 into original position of R5
	MOV R0, #1
	B ENDSUB
	
DONOTSWAP: 
	MOV R0, #0
	B ENDSUB
	
ENDSUB: 
	POP {R2, R4, R5, PC}
	
END:
	B END

.end
	