		B main

verses 	DEFW	4

men_mow	DEFB	" men went to mow\n", 0
went_mo	DEFB	"Went to mow a meadow\n", 0
men	DEFB	" men",0
man1	DEFB	" man went to mow\n",0
spot	DEFB	" man and his dog, Spot\n",0
comma	DEFB	", ",0
; Insert any strings here

		ALIGN
main
	LDR	R1,verses
	
first	CMP	R1,#0
	BEQ	zero
	CMP	R1,#1
	BNE	primary
	MOV	R0,#1
	SWI	4
	ADR	R0,man1
	SWI	3
	ADR	R0,went_mo
	SWI	3
	MOV	R0,#1
	SWI	4
	ADR	R0,spot
	SWI	3
	ADR	R0,went_mo
	SWI	3
	SWI	2	

primary
	MOV	R0,R1
	SWI	4
	ADR	R0,men_mow
	SWI	3
	ADR	R0,went_mo
	SWI	3
	MOV	R2,R1
prim2	CMP	R2,#1
	BNE	second
	MOV	R0,#1
	SWI	4
	ADR	R0,spot
	SWI	3
	ADR	R0,went_mo
	SWI	3
	MOV	R0,#10
	SWI	0
	SUB	R1,R1,#1
	B	first
	
second	MOV	R0,R2
	SWI	4
	ADR	R0,men
	SWI	3
	ADR	R0,comma
	SWI	3
	SUB	R2,R2,#1
	B	prim2

zero	SWI	2
; Insert your code here