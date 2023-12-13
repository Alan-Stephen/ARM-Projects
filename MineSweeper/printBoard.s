        B test_printBoard

; Our board 
; 0, represents an empty space
; 1-8 represents the number of bombs around us
; -1 represents there is a bomb at this location
; No more than 8 bombs
tpb_board   DEFW  1,-1, 1, 0, 0, 1,-1,-1, 1, 1, 1, 0, 0, 1, 3,-1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1,-1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1,-1, 1, 0, 0, 1, 1, 2, 2, 2, 1, 0, 0, 1,-1, 2,-1, 1, 0, 0, 0



        ALIGN
test_printBoard    
        ADR	R0, tpb_board 
        BL	printBoard
        SWI	2

; printBoard -- print the board 
; Input: R0 <-- Address of board
printBoard
	MOV	R1,R0
	MOV	R2,#0
	MOV	R3,#1
	
	;Printing x axis
	;inital padding spaces
	MOV	R0,#32
	SWI	0
	SWI	0
	SWI	0
	;SWI	0
	;SWI	0
	
topLoop	MOV	R0,#32
	SWI	0
	SWI	0
	MOV	R0,R3
	SWI	4
	MOV	R0,#32
	SWI	0
	SWI	0
	ADD	R3,R3,#1
	CMP	R3,#9
	BNE	topLoop
	
	MOV	R0,#10
	SWI	0
	SWI 	0
	;resetting val of R3 and printing y axis
	MOV	R3,#1
	
yaxis	MOV	R0,R3
	SWI	4
	MOV	R0,#32
	SWI	0
	SWI	0
	;SWI	0
	;SWI	0
	
loop	MOV	R0,#32
	SWI	0
	SWI	0
	LDRB	R0,[R1],#4
	CMP	R0,#0
	BEQ	spaces
	CMP	R0,#255
	BEQ	mine
	SWI	4
back	MOV	R0,#32
	SWI	0
	SWI	0
	ADD	R2,R2,#1
	AND	R0,R2,#7
	
	CMP	R2,#64
	BGE	end
	CMP	R0,#0
	BEQ	NewLine
	
	B	loop
	
end	MOV	PC,R14
	SWI	2
	
NewLine
	MOV	R0,#10
	SWI	0
	SWI	0
	ADD	R3,R3,#1
	B	yaxis
	
spaces
	MOV	R0,#32
	SWI	0
	B	back
	
mine	MOV	R0,#77
	SWI	0
	B	back


   
