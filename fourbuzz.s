		B main

n		DEFW 	37
buzz	DEFB "Buzz",0
fourth	DEFB "Fourth " ,0

		ALIGN

main	LDR R2, n
		MOV R1, #1
		

loop	MOV R0, R1
		SWI 4

		MOV R0,#10
		SWI 0
		
		ADD R1, R1, #1
		AND R0,R1,#3
		CMP R0,#0
		BEQ buzzz
		CMP R1, R2
		BLE loop
End		SWI 2

		
		
buzzz		
		CMP R1,R2
		BGT End
		ADD R3,R3,#1
		ADD R1,R1,#1
		AND R0,R3,#3
		CMP R0,#0
		BEQ FourthB
		ADR R0,buzz
		SWI 3
		MOV R0,#10
		SWI 0
		B   loop

FourthB

		ADR R0,fourth
		SWI 3
		ADR R0,buzz
		SWI 3
		CMP R1,R2
		BGT End
		MOV R0,#10
		SWI 0
		B   loop
		
		


