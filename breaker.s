B main
width	DEFW 8

; Use this buffer to store your words, there's space for words up to 32 bytes long
;
; When you store characters here, it will overwrite the values that already exist.
buffer	DEFB "0123456890123456789012345678901",0 

		ALIGN
main	
; You will need to insert any setup code to 
		ADR 	R3,buffer
		LDR	R4,width
; execute before the loop here
		B 	readChar
loop	
;		Print character
	      
readChar	
		SWI 	1
		CMP	R0,#10
		BEQ	return
		CMP 	R0, #'#'
		BEQ	End
		CMP	R0,#32
		BEQ	space
		STRB	R0, [R3]
		ADD	R3,R3,#1
		ADD	R1,R1,#1
		B	loop
End		SWI 	2
		
space
		CMP	R1,#0
		BEQ	loop
		ADD	R0,R1,R5
		CMP	R0,R4
		BEQ	exactline
		BGT	newline

		MOV	R0,#0
		STRB	R0, [R3]
		ADD	R3,R3,#1
		ADR	R0, buffer
		SWI	3
		ADD	R5,R5,R1
		ADD	R5,R5,#1
		MOV	R1,#0
		ADR	R3,buffer
		MOV	R0,#32
		SWI	0
		B	loop

newline
		MOV	R0,#10
		SWI	0
		MOV	R0,#0
		STRB	R0,[R3]
		ADR	R0,buffer
		SWI	3
		MOV	R0,#32
		SWI	0
		MOV	R5,R1
		ADD	R5,R5,#1
		MOV	R1,#0
		ADR	R3,buffer
		B	loop
	
return		
		ADD	R0,R1,R5
		CMP	R0,R4
		BLT	skip
		MOV	R0,#10
		SWI	0
skip		MOV	R0,#0
		STRB	R0,[R3]
		ADR	R0,buffer
		SWI	3
		MOV	R0,#10
		SWI	0
		MOV	R1,#0
		MOV	R5,#0
		ADR	R3,buffer
		B	loop
exactline
		MOV	R0,#0
		STRB	R0, [R3]
		ADD	R3,R3,#1
		ADR	R0, buffer
		SWI	3
		ADD	R5,R5,R1
		ADD	R5,R5,#1
		MOV	R1,#0
		ADR	R3,buffer
		B	loop
