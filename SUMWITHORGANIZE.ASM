.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "THE SUM OF "
NUM1 DB ?
MSG2 DB " AND "
NUM2 DB ?
MSG3 DB " IS : "
SUM DB ?
MSG4 DB "$"
.CODE
MAIN PROC

MOV AX, @DATA            ; Initialize the data segment
MOV DS, AX

; Prompt and take the first input
MOV AH, 1
INT 21H
MOV BL, AL
MOV NUM1, BL

; Prompt and take the second input
MOV AH, 1
INT 21H
MOV BH, AL
MOV NUM2, BH

; Calculate the sum
ADD BL, BH
SUB BL, 48

; Display the result
MOV SUM, BL
LEA DX, MSG1
MOV AH, 9
INT 21H

MOV AH, 4CH
INT 21H
MAIN ENDP
END MAIN