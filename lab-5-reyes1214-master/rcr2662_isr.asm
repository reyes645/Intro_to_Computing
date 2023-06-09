.ORIG x4000


; SAVE REGISTERS TO RESTORE LATER
	ST R0 ZERO
	ST R1 ONE
	ST R2 TWO
	ST R3 THREE
	ST R4 FOUR
	ST R5 FIVE
	ST R6 SIX
	ST R7 SEVEN
; CHECK THE TYPE OF CHARACTER AND PERFORM THE APPROPRIATE ACTION
	LDI R1 KBDR
	LD R2 ASCII_NUM
	ADD R5 R2 R1
	BRN SPECIAL
	BRZ NUM
	LD R2 ENDNUM
	ADD R5 R2 R1
	BRN NUM
	LD R2 ASCII_UC
	ADD R5 R2 R1
	BRN SPECIAL
	BRZ UC
	LD R2 ENDUC
	ADD R5 R2 R1
	BRN UC
	LD R2 ASCII_LC
	ADD R5 R2 R1
	BRN SPECIAL
	BRZ LC
	LD R2 ENDLC
	ADD R5 R2 R1
	BRN LC
	BR SPECIAL
; NUMBER

NUM	LEA R2 STRING3
	LDR R3 R2 #0
	BRZ END
CHECK	LDI R4 DSR
	BRZ CHECK
	STI R3 DDR
	ADD R2 R2 #1
	BR NUM

; UPPERCASE

UC	LEA R2 STRING1
	LDR R3 R2 #0
	BRZ END
CHECK1	LDI R4 DSR
	BRZ CHECK1
	STI R3 DDR
	ADD R2 R2 #1
	BR UC

; LOWERCASE

LC	LEA R2 STRING2
	LDR R3 R2 #0
	BRZ END
CHECK2	LDI R4 DSR
	BRZ CHECK2
	STI R3 DDR
	ADD R2 R2 #1
	BR LC

; HALT WHEN any special character is pressed

SPECIAL	LEA R2 STRING4
	LDR R3 R2 #0
	BRZ FINISH
CHECK3	LDI R4 DSR
	BRZ CHECK3
	STI R3 DDR
	ADD R2 R2 #1
	BR SPECIAL
FINISH	HALT

; RESTORE THE REGISTER VALUES

END	LD R0 ZERO
	LD R1 ONE
	LD R2 TWO
	LD R3 THREE
	LD R4 FOUR
	LD R5 FIVE
	LD R6 SIX
	LD R7 SEVEN

; Returning back to User Program

	RTI




ASCII_NUM .FILL x-30
ENDNUM	  .FILL x-3A
ASCII_LC  .FILL x-61
ENDLC	  .FILL x-7B
ASCII_UC  .FILL x-41
ENDUC	  .FILL x-5B
KBDR .FILL xFE02
DSR .FILL xFE04
DDR .FILL xFE06
STRING1 .STRINGZ "\nWHAT STARTS HERE CHANGES THE WORLD\n"
STRING2 .STRINGZ "\nHook'em, Horns!\n"
STRING3 .STRINGZ "\nTEXAS FIGHT\n"
STRING4 .STRINGZ "\n ---------- END OF EE306 LABS -------------\n"
ZERO	.BLKW x1
ONE	.BLKW x1
TWO	.BLKW x1
THREE	.BLKW x1
FOUR	.BLKW x1
FIVE	.BLKW x1
SIX	.BLKW x1
SEVEN	.BLKW x1
.END
