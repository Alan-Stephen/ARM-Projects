		B main

table	DEFW	13
is		DEFB 	" is ",0

		ALIGN

main		MOV	R2,#0
		LDR 	R1,table
		MOV	R3,#0
		
repeat		CMP	R1,R2
		BPL	IncrementByTable
		SWI	2

		
IncrementByTable
		MOV	R0,R2
		SWI	4
		MOV	R0,#'x'
		SWI	0
		MOV	R0,R1
		SWI	4
		ADR	R0,is
		SWI	3
		MOV	R0,R3
		SWI	4
		MOV	R0,#10
		SWI	0
		ADD	R3,R3,R1
		ADD	R2,R2,#1
		B	repeat
		