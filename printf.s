	B main

fs1	DEFB	"%d green %s sitting on a wall%c\n",0
fs2	DEFB	"This is a test containg nothing but a %%\n",0
fs3	DEFB	"%d %d %d %d %d.\n%s!\n\n%s\n",0
bottleString	DEFB "bottles",0
blast	DEFB	"Blast Off!",0
hello	DEFB	"Hello Universe",0
	ALIGN
seq1	DEFW	10,bottleString, '.'
seq2	DEFW	1
seq3	DEFW	5,4,3,2,1,blast,hello

main	ADR R1,fs3		; Feel free to change these to point to the other format specifiers and value sequencei
	ADR R2,seq3

printf
; You should start your program here
; DO NOT modify any of the code above (other than to try different tests -- the pipeline will run further tests as well.)

loop	LDRB 	R0, [R1]
	CMP	R0,#'%'
	BEQ	percentile
	CMP	R0,#0
	BEQ	end
	SWI	0
	ADD	R1,R1,#1
	B	loop
end	SWI 	2

percentile
	ADD	R1,R1,#1
	LDRB	R0, [R1]
	CMP	R0,#'d'
	BEQ	integer
	CMP	R0,#'s'
	BEQ	string
	CMP	R0,#'c'
	BEQ	char
	CMP	R0,#'%'
	BEQ	againPercentile
	ADD	R1,R1,#1
	B	loop

integer
	LDR	R0, [R2]
	SWI	4
	ADD	R2,R2,#4
	ADD	R1,R1,#1
	B	loop
string
	LDR	R0, [R2]
	SWI 	3
	ADD	R2,R2,#4
	ADD	R1,R1,#1

	B	loop
char
	LDR	R0, [R2]
	SWI 	0
	ADD	R2,R2,#4
	ADD	R1,R1,#1

	B	loop
againPercentile
	SWI	0
	ADD	R1,R1,#1
	B	loop