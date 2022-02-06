.text
.global _start
_start:
LDR R1, =TEST_NUM
LDR R2, [R1]
MOV R7, #0   // sum of the elements in the array
MOV R8, #0   // count of num positive


LOOP:   CMP R2, #0 
		BLE END
		ADD R7, R7, R2
		ADD R8, R8, #1
		ADD R1, R1, #4  // go to next index
		LDR R2, [R1]  
		B LOOP 

END: B END
	

.end