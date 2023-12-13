        B test_generateBoard


; Our board 
; 0, represents an empty space
; 1-8 represents the number of bombs around us
; 66 represents there is a bomb at this location
; No more than 8 bombs
testGenboard   
        DEFW  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
tgbBoardMask
        DEFW  0,0,0,0,0, 0,0, 0,0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0, 0, 0,0,0,0,0,0,0,0,0,0, 0, 0,0,0,0,0, 0,0, 0,0,0,0,0,0,0, 0,0,0,0,0,0, 0,0,0,0, 0, 0,0,0

        ALIGN
test_generateBoard
        MOV R13, #0x10000
	ADR R0, testGenboard 
        BL generateBoard

        ADR R0, testGenboard 
        ADR R1, tgbBoardMask
        BL printMaskedBoard
        SWI 2


; generateBoard
; Input R0 -- array to generate board in
generateBoard
	STR	R14,[R13,#-4]!
	STR	R4,[R13,#-4]!
	STR	R5,[R13,#-4]!
	STR	R6,[R13,#-4]!
	STR     R7,[R13,#-4]!
	MOV	R1,R0
	MOV	R3,#0
	;plant mines
	
pickran	
	STRB	R1,[R13,#-4]!
	BL	randu
	LDRB	R1,[R13],#4
	MOV 	R0, R0 ASR #8
	AND 	R0, R0, #63

	LDR	R2,[R1, R0 LSL #2]
	CMP	R2,#-1
	BEQ	pickran
	MOV	R2,#-1
	STR	R2,[R1,R0 LSL #2]
	
	ADD	R3,R3,#1
	CMP	R3,#8
	BLT	pickran
	
	;generate rest of the grid
	MOV	R2,#1
	MOV	R3,#1
	MOV	R4,#1

	
	
	;Iterate until -1 found
next	CMP 	R2,#64
	BEQ	return
	CMP	R3,#8
	BEQ	nextcols
	
	LDR	R0,[R1,R2 LSL #2]
	ADD	R2,R2,#1
	ADD	R3,R3,#1
	
	CMP	R0,#-1
	BEQ 	update
	B	next
	
nextcols
	ADD	R4,R4,#1
	MOV	R3,#0
	B	next
	
update
	SUB	R3,R3,#1 
	SUB	R4,R4,#1
	MOV	R5,R3 ;;these are temp variables, they could be replaces by just r3 and r4 idk yet
	MOV	R6,R4 ;;R4 is rows R3 is columns
	
	;;minus 1 to make to usable with formula for index


	;; left of middle
	SUB	R3,R3,#1
	CMP	R3,#0
	BLT	notML
	
	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notML
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notML	MOV	R3,R5

 
	;;right of middle
	ADD	R3,R3,#1
	CMP	R3,#8
	BGE	notMR
	
	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notMR
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notMR	MOV	R3,R5
	  
;;examining top right
	SUB	R4,R4,#1
	CMP	R4,#0
	BLT	notTR
	ADD	R3,R3,#1
	CMP	R3,#8
	BGE	notTR
	
	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notTR
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notTR	MOV	R3,R5
	MOV	R4,R6

;;examining top middle
	SUB	R4,R4,#1
	CMP	R4,#0
	BLT	notTM
	
	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notTM
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notTM	MOV	R4,R6	


;;examining top left
	SUB	R3,R3,#1
	CMP	R3,#0
	BLT	notTL
	SUB	R4,R4,#1
	CMP	R4,#0
	BLT	notTL
	
	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notTL
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notTL	MOV	R3,R5
	MOV	R4,R6
;;bottom left
	SUB	R3,R3,#1
	CMP	R3,#0
	BLT	notBL
	ADD	R4,R4,#1
	CMP	R4,#8
	BGE	notBL

	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notBL
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notBL 	MOV	R3,R5
	MOV	R4,R6
;;bottom middle
	ADD	R4,R4,#1
	CMP	R4,#8
	BGE	notBM
	
	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notBM
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notBM	MOV	R4,R6
;;bottom right
	ADD	R4,R4,#1
	CMP	R4,#8
	BGE	notBR
	ADD	R3,R3,#1
	CMP	R3,#8
	BGE	notBR
	
	MOV	R0,#8
	MUL	R0,R0,R4
	ADD	R0,R0,R3
	LDR	R7,[R1,R0 LSL #2]
	CMP	R7,#-1
	BEQ	notBR
	ADD	R7,R7,#1
	STR	R7,[R1,R0 LSL #2]
notBR	
	ADD	R5,R5,#1
	ADD	R6,R6,#1	
	MOV	R3,R5
	MOV	R4,R6
	B	next


return
	LDR     R7,[R13],#4
	LDR	R6,[R13],#4
	LDR	R5,[R13],#4
	LDR	R4,[R13],#4
	LDR	R14,[R13],#4
	MOV	PC,R14
	SWI	2	
	
	;change system so it always assumes it's in the middle, implement more coord validity checking.

; randu -- Generates a random number
; Input: None
; Ouptut: R0 -> Random number
randu   LDR R2,mult
        MVN R1,#0x80000000
        LDR R0,seed
        MUL R0,R2,R0
        AND R0,R0,R1
        STR R0,seed
        MOV PC, R14

        ALIGN
seed    DEFW    0xC0FFEE
mult    DEFW    65539

        ALIGN
        include printMaskedBoard.s
        ALIGN
        SWI 2
