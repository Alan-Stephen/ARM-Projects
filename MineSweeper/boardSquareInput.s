        B test_BoardSquareInput

tprompt  DEFB "Enter square to reveal: ",0
tmesg    DEFB "You entered the index ",0

    ALIGN
test_BoardSquareInput
        ADR R0, tprompt
        BL boardSquareInput

        MOV R1, R0
        ADR R0, tmesg
        SWI 3
        MOV R0,R1
        SWI 4
        MOV R0,#10
        SWI 0
        SWI 2


; boardSquareInput -- read board position from keyboard
; Input:  R0 ---> prompt string address
; Ouptut: R0 <--- index

boardSquareInput
	STRB	R4,[R13,#-4]!
	MOV	R4,R0
	B	start
	
restart	MOV	R0,#	10
	SWI	0

start	MOV	R0,R4
	SWI	3
	
	SWI	1
	SWI	0
	MOV	R1,R0
	CMP	R1,#'1'
	BLT	restart
	CMP	R1,#'8'
	BGT	restart

	SWI	1
	SWI	0
	MOV	R2,R0	
	CMP	R2,#','
	BNE	restart
	
	SWI	1	
	SWI	0
	MOV	R3,R0
	CMP	R3,#'1'
	BLT	restart
	CMP	R3,#'8'
	BGT	restart
	
	SWI	1
	SWI	0
	CMP	R0,#10
	BNE	start
	
	SUB	R1,R1,#49
	SUB	R3,R3,#49
	MOV	R0,#8
	MUL	R0,R0,R1
	ADD	R0,R0,R3
	
	LDRB	R4,[R13],#4
	MOV	PC,R14
	SWI	2
