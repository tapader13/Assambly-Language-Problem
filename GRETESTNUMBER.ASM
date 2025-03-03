.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "ENTER FIRST NUMBER: $"
MSG2 DB "ENTER SECOND NUMBER: $"
MSG3 DB "ENTER THIRD NUMBER: $"
MSG4 DB "THE GREATEST NUMBER IS: $"

.CODE
MAIN PROC

MOV AX, @DATA            ; Initialize the data segment
MOV DS, AX

; Prompt and take the first input
LEA DX, MSG1
MOV AH, 9
INT 21H

MOV AH, 1               ; Take input from user
INT 21H
MOV BL, AL              ; Store first number in BL

; Prompt and take the second input
LEA DX, MSG2
MOV AH, 9
INT 21H

MOV AH, 1               ; Take input from user
INT 21H
MOV CL, AL              ; Store second number in CL

; Prompt and take the third input
LEA DX, MSG3
MOV AH, 9
INT 21H

MOV AH, 1               ; Take input from user
INT 21H
MOV DL, AL              ; Store third number in DL

; Compare first number (BL) and second number (CL)
CMP BL, CL
JG  FIRST_LARGER
JL  SECOND_LARGER

; If first and second numbers are equal, compare with third number (DL)
CMP BL, DL
JG  FIRST_LARGER
JL  THIRD_LARGER

; If all are equal, print one of them
LEA DX, MSG4
MOV AH, 9
INT 21H

MOV AH, 2
MOV DL, BL
INT 21H
JMP DONE

FIRST_LARGER:
LEA DX, MSG4
MOV AH, 9
INT 21H

MOV AH, 2
MOV DL, BL
INT 21H
JMP DONE

SECOND_LARGER:
LEA DX, MSG4
MOV AH, 9
INT 21H

MOV AH, 2
MOV DL, CL
INT 21H
JMP DONE

THIRD_LARGER:
LEA DX, MSG4
MOV AH, 9
INT 21H

MOV AH, 2
MOV DL, DL
INT 21H
JMP DONE

DONE:
MOV AH, 4CH
INT 21H

MAIN ENDP
END MAIN
