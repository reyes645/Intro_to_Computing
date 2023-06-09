.ORIG X3000
	
	LEA R0 HEADER
	TRAP x22
	BRNZP START
END	AND R0 R0 #0
	AND R1 R1 #0
	AND R2 R2 #0
	AND R3 R3 #0
	AND R4 R4 #0
	AND R5 R5 #0
	AND R6 R6 #0
	AND R7 R7 #0
	
	HALT

START	AND R0 R0 #0
	AND R1 R1 #0
	AND R2 R2 #0
	AND R3 R3 #0
	AND R5 R5 #0
	AND R7 R7 #0
	AND R6 R6 #0
	ADD R6 R6 #-1
	AND R4 R4 #0
	ADD R4 R4 #-2
	LEA R3 STORAGE
	LD R0 ENTER
	TRAP x21
	TRAP x21
	LEA R0 PROMPT
	TRAP x22
TYPE	TRAP x20
	TRAP x21
	LD R1 NEGENT
	ADD R2 R1 R0
	BRZ ENT
	LD R1 NEGSPA
	ADD R2 R1 R0
	BRZ SPA
	LD R1 NEGQUO
	ADD R2 R1 R0
	BRZ QUO
STORE	STR R0 R3 #0
	ADD R3 R3 #1
	BRNZP TYPE
ENT	AND R0 R0 #0
	STR R0 R3 #0
	LD R1 STORAGE
	BRNP CHECK
	BRNZP START
SPA	ADD R6 R6 #1
	BRNP STORE
	AND R0 R0 0
	BRNZP STORE
QUO	ADD R4 R4 #1
	BRNP STORE
	AND R0 R0 #0
	BRNZP STORE
	

HEADER	.STRINGZ "UT Resource Map"
PROMPT	.STRINGZ "Enter a command: "
ENTER	.FILL	#10
NEGENT	.FILL	#-10
NEGSPA	.FILL 	#-32
NEGQUO	.FILL	#-34
EXIT	.STRINGZ "exit"
FIND	.STRINGZ "find"
LIST	.STRINGZ "list"
ADD1	.STRINGZ "add"
PTR	.FILL X6000

CHECK	LEA R0, STORAGE
	LEA R1, EXIT

	JSR LEAVE

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz MATCHE
	ADD R1 R1 #1
	LEA R0, STORAGE
	BRNZP AGAIN

MATCHE 	BRNZP END

LEAVE	ST R2, SAVER13
	ST R4, SAVER14
	ST R5, SAVER15

	ADD R2, R0, #0
	AND R0, R0, #0
loop0	LDR R4, R1, #0
	BRz end_loop0
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRnp nomatch0
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop0
nomatch0 ADD R0, R0, #1
end0	LD R2, SAVER13
	LD R4, SAVER14
	LD R5, SAVER15
	RET
end_loop0 LDR R5,R2, #0
	 BRnp nomatch0
	 BR end0
SAVER13 .BLKW x1
SAVER14 .BLKW x1
SAVER15 .BLKW x1
	
AGAIN	LEA R0, STORAGE
	LEA R1, FIND

	JSR STRCMP

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz WHICH
	ADD R1 R1 #1
	LEA R0, STORAGE
	BRNZP AGAIN2

 	
WHICH	LD R1 NEGQUO
	LEA R0, STORAGE
	ADD R0 R0 #5
	LDR R3 R0 #0
	ADD R2 R1 R3
	BRNP TWO

	JSR LO
	BRNZP START
TWO	JSR RES
	BRNZP START

STRCMP	ST R2, SAVER1
	ST R4, SAVER2
	ST R5, SAVER3

	ADD R2, R0, #0
	AND R0, R0, #0
loop1	LDR R4, R1, #0
	BRz end_loop1
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRnp nomatch1
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop1
nomatch1 ADD R0, R0, #1
end1	LD R2, SAVER1
	LD R4, SAVER2
	LD R5, SAVER3
	RET
end_loop1 LDR R5,R2, #0
	 BRnp nomatch1
	 BR end1
SAVER1 .BLKW x1
SAVER2 .BLKW x1
SAVER3 .BLKW x1

AGAIN2	LEA R0, STORAGE
	LEA R1, LIST

	JSR MAYBE1

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz MATCHL
	ADD R1 R1 #1
	LEA R0, STORAGE
	BRNZP AGAIN3

MATCHL  JSR LIS
AWAY	BRNZP START

MAYBE1	ST R2, SAVER4
	ST R4, SAVER5
	ST R5, SAVER6

	ADD R2, R0, #0
	AND R0, R0, #0
loop2	LDR R4, R1, #0
	BRz end_loop2
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRnp nomatch2
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop2
nomatch2 ADD R0, R0, #1
end2	LD R2, SAVER4
	LD R4, SAVER5
	LD R5, SAVER6
	RET
end_loop2 LDR R5,R2, #0
	 BRnp nomatch2
	 BR end2
SAVER4 .BLKW x1
SAVER5 .BLKW x1
SAVER6 .BLKW x1

STORAGE	.BLKW	x60

AGAIN3	LEA R0, STORAGE
	LEA R1, ADD1

	JSR MAYBE2

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz MATCHA
	ADD R1 R1 #1
	LEA R0, STORAGE
	BRNZP AGAIN4

MATCHA 	JSR AD
	BRNZP AWAY

MAYBE2	ST R2, SAVER7
	ST R4, SAVER8
	ST R5, SAVER9

	ADD R2, R0, #0
	AND R0, R0, #0
loop3	LDR R4, R1, #0
	BRz end_loop3
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRnp nomatch3
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop3
nomatch3 ADD R0, R0, #1
end3	LD R2, SAVER7
	LD R4, SAVER8
	LD R5, SAVER9
	RET
end_loop3 LDR R5,R2, #0
	 BRnp nomatch3
	 BR end3
SAVER7 .BLKW x1
SAVER8 .BLKW x1
SAVER9 .BLKW x1


AGAIN4 	LEA R0, STORAGE
DELETE	.STRINGZ "del"
	LEA R1, DELETE

	JSR MAYBE3

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz MATCHD
ERROR	.STRINGZ "Error: Invalid command!"
	LEA R0 ERROR
	TRAP x22
	JSR START

MATCHD 	LEA R0 STORAGE
	JSR DE
	BRNZP AWAY

MAYBE3	ST R2, SAVER10
	ST R4, SAVER11
	ST R5, SAVER12

	ADD R2, R0, #0
	AND R0, R0, #0
loop4	LDR R4, R1, #0
	BRz end_loop4
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRnp nomatch4
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop4
nomatch4 ADD R0, R0, #1
end4	LD R2, SAVER10
	LD R4, SAVER11
	LD R5, SAVER12
	RET
end_loop4 LDR R5,R2, #0
	 BRnp nomatch4
	 BR end4 
SAVER10 .BLKW x1
SAVER11 .BLKW x1
SAVER12 .BLKW x1



LO	.BLKW X1
	LEA R0 STORAGE
	ST R7 LO
	ADD R0 R0 #6
	LD R2 PTR1
REPEAT	LDR R2 R2 #0
	
	BRNP RESOURCE
	BRNZP DUH
ERROR1	.STRINGZ "Error: This location doesn't exist!"
DUH	LEA R0 ERROR1
	TRAP x22
	LD R7 LO
	RET
RESOURCE LDR R1 R2 #0
	


	JSR COMPARE1

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz NEW
	ADD R2 R2 #2
	LEA R0 STORAGE
	ADD R0 R0 #6
	BRNZP REPEAT
	

NEW	ADD R3 R2 #1
	LDR R4 R3 #0
	BRNZP CONVERT
GASP	.FILL X30
CONVERT	LD R7 GASP
	ADD R4 R4 R7
	BRNZP YEET
MASK1	.FILL xFF00
YEET	LD R5 MASK1
	BRNZP MEEP
COUNTER	.FILL #-8
MEEP	LD R6 COUNTER
	AND R0 R4 R5
BACK 	ADD R0 R0 #0
	BRP DOUBLE
	ADD R0 R0 R0
	ADD R0 R0 #1
	ADD R6 R6 #1
	BRN BACK
	BRNZP OKUR
DOUBLE	ADD R0 R0 R0
	ADD R6 R6 #1 
	BRN BACK
OKUR	TRAP x21
	BRNZP YIKES
MASK2	.FILL x00FF
YIKES	LD R6 MASK2
	AND R0 R4 R6
	TRAP x21
	LD R7 LO 
	RET

COMPARE1 ST R2, SAVER21
	ST R4, SAVER41
	ST R5, SAVER51

	ADD R2, R0, #0
	AND R0, R0, #0
loop5	LDR R4, R1, #0
	BRz end_loop5
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRnp nomatch5
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop5
nomatch5 ADD R0, R0, #1
end5	LD R2, SAVER21
	LD R4, SAVER41
	LD R5, SAVER51
	RET
end_loop5 LDR R5,R2, #0
	 BRnp nomatch5
	 BR end5 
SAVER21 .BLKW x1
SAVER41 .BLKW x1
SAVER51 .BLKW x1

LIS	.BLKW X1
	ST R7 LIS
	LD R2 PTR1
CYCLE1	LDR R2 R2 #0
	BRNP GO
	LD R7 LIS
	RET 
GO	LDR R0 R2 #0
	TRAP x22
PRINT	.STRINGZ " - "
	LEA R0 PRINT
	TRAP x22
	ADD R2 R2 #1
	LDR R4 R2 #0
	LD R5 GASP
	ADD R4 R4 R5
	LD R5 MASK1
	LD R6 COUNTER
	AND R0 R4 R5
BACK1 	ADD R0 R0 #0
	BRN DOUBLE1
	ADD R0 R0 R0
	ADD R6 R6 #1
	BRZ DUN
	BRNZP BACK1
DOUBLE1	ADD R0 R0 R0
	ADD R0 R0 #1
	ADD R6 R6 #1 
	BRN BACK1
DUN	TRAP x21
	LD R6 MASK2
	AND R0 R4 R6
	TRAP x21
	ADD R2 R2 #1
	BRNZP HUSH
PEW	.FILL #10
HUSH	LDR R0 R2 #0
	BRZ CYCLE1
	LD R0 PEW
	TRAP x21
	BRNZP CYCLE1 
	
		
STORAGE1 .FILL x30E4
RES	.BLKW X1
	ST R7 RES
	BRNZP SKRT
PTR1	.FILL x6000
SKRT	LD R7 STORAGE1
	LD R6 GASP
	NOT R6 R6 
	ADD R6 R6 #1
	LDR R1 R7 #5
	LDR R3 R7 #6
	LD R4 COUNTER
TOOP	ADD R1 R1 R1
	ADD R4 R4 #1
	BRN TOOP
	ADD R7 R1 R3
	ADD R7 R7 R6
	LD R2 PTR1
CYCLE	LDR R2 R2 #0
	BRNP DOWN
	LD R7 RES
	RET 
DOWN	ADD R1 R2 #1
	LDR R1 R1 #0
	NOT R6 R1 
	ADD R6 R6 #1
	ADD R5 R6 R7 
	BRNP NO
	LDR R0 R2 #0
	TRAP x22
	BRNZP G
A	.FILL #10
G	ADD R2 R2 #2
	LDR R0 R2 #0
	BRNP DOWNer
	LD R7 RES
	RET 
DOWNer	ADD R1 R0 #1
	LDR R1 R1 #0
	NOT R6 R1 
	ADD R6 R6 #1
	ADD R5 R6 R7 
	BRNP CYCLE
	LD R0 A
	TRAP x21
	BRNZP CYCLE
NO	ADD R2 R2 #2
	BRNZP CYCLE
	
	
DE	.BLKW x1
YOU	.BLKW x1
	ST R7 DE
	ADD R0 R0 #5
	ST R0 YOU
	LD R2 PTR1
NODE	LD R0 YOU
	ADD R3 R2 #0
	LDR R2 R2 #0
	BRNP CONTINUE
	
	LD R0 PEW
	TRAP x21
	BRNZP NOM
ERROR2	.STRINGZ "Error: This resource doesn't exist!"
NOM	LD R0 ERROR2
	TRAP x22
	LD R7 DE
	RET
CONTINUE LDR R1 R2 #0

	JSR DC

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz DELETION
	ADD R2 R2 #2
	BRNZP NODE
DELETION  ADD R2 R2 #2
	LDR R4 R2 #0
	STR R4 R3 #0
	LD R7 DE
	RET
	

DC	ST R2, SAVER23
	ST R4, SAVER43
	ST R5, SAVER53

	ADD R2, R0, #0
	AND R0, R0, #0
loop7	LDR R4, R1, #0
	BRz end_loop7
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRnp nomatch7
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop7
nomatch7 ADD R0, R0, #1
end7	LD R2, SAVER23
	LD R4, SAVER43
	LD R5, SAVER53
	RET
end_loop7 LDR R5,R2, #0
	 BRnp nomatch7
	 BR end7 
SAVER23 .BLKW x1
SAVER43 .BLKW x1
SAVER53 .BLKW x1

AD	.BLKW X1
	ST R7 AD
	ADD R0 R0 #5
	LD R2 PTR1
POP	LDR R2 R2 #0
	BRNP FILLED
BACKUP	.BLKW x1
	ST R2 BACKUP
	AND R2 R2 #0
	BRNZP OOPS2
NEW_HOME .FILL X8000
OOPS2	LD R4 NEW_HOME
	LD R2 PTR1
	STR R4 R2 #0
ADDING	STR R0 R4 #0
WOW	ADD R6 R0 #1
	ADD R2 R2 #1
	LDR R5 R0 #0
	BRZ LOCA
	BRNZP WOW
LOCA	.BLKW x1
	ST R3 LOCA
	LD R3 COUNTER
	ADD R6 R0 R2
	ADD R6 R6 #1
	ADD R4 R4 #1
	LDR R5 R6 #0
DOUBLER	ADD R5 R5 R5
	ADD R3 R3 #1
	BRZ WOOF
	BRNZP DOUBLER
WOOF	ADD R6 R6 #1
	BRNZP POO
CON	.FILL #-30
POO	LD R2 CON
	ADD R3 R6 R2
	ADD R2 R3 R5
	STR R2 R4 #0
	BRNP ADDING
	LD R7 AD
	RET
	
FILLED 	
	LDR R1 R2 #0

	JSR INSERT

	AND R0, R0, #1	; CHECKING THE OUTPUT ARGUMENT OF SUB-ROUTINE
	BRz TRIP
	BRP NEW_NODE
	
	ADD R2 R2 #2
	BRNZP POP
	

NEW_NODE LD R5 NEW_HOME
	LDR R7 R2 #0
	LDR R1 R5 #0
	BRNP NEWER
	STR R4 R5 #0
	STR R7 R5 #2
	BRNZP ESCAPE
NEWER	ADD R5 R5 #4
	STR R5 R2 #0
	STR R4 R5 #0
	STR R7 R5 #2
ESCAPE	LD R7 AD
	RET
	
NEW3 	.FILL #10
TRIP	LD R0 NEW3
ERROR3	.STRINGZ "Error: This resource already exists!"
	TRAP x22
	LD R7 AD
	RET



INSERT	ST R2, SAVER24
	ST R4, SAVER44
	ST R5, SAVER54
	
	AND R6 R6 #0
	ADD R2, R0, #0
	AND R0, R0, #0
loop8	LDR R4, R1, #0
	BRz end_loop8
	LDR R5, R2, #0
	NOT R5,R5
	ADD R5, R5, #1
	ADD R5, R5, R4
	BRn NEGATIVE
	BRP POSITIVE
	ADD R1, R1, #1
	ADD R2, R2, #1
	BR loop8
NEGATIVE ADD R0, R0, #-1
	BRNZP end8
POSITIVE ADD R6, R6, #1
end8	LD R2, SAVER24
	LD R4, SAVER44
	LD R5, SAVER54
	RET
end_loop8 LDR R5,R2, #0
	 
	 BR end8
SAVER24 .BLKW x1
SAVER44 .BLKW x1
SAVER54 .BLKW x1





	

	
	
.END