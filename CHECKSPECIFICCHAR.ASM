.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "ENTER CHARACTER A OR a: $"
MSG2 DB "ENTER CHARACTER IS A$"
MSG3 DB "ENTER CHARACTER IS a$"
MSG4 DB "ENTER CHARACTER IS NOT A OR a$"

.CODE
MAIN PROC

MOV AX, @DATA            ; Initialize the data segment
MOV DS, AX

; Prompt and take the input
LEA DX, MSG1
MOV AH, 9
INT 21H

MOV AH, 1                ; DOS function to take input
INT 21H
MOV BL, AL               ; Store input character in BL

; Check if input is 'A' or 'a'
CMP BL, 'A'              ; Compare input with 'A'
JE IS_A             ; If equal, jump to IS_A_OR_a
CMP BL, 'a'              ; Compare input with 'a'
JE IS_aa             ; If equal, jump to IS_A_OR_a

; If input is not 'A' or 'a', print "ENTER CHARACTER IS NOT A OR a"
LEA DX, MSG4
MOV AH, 9
INT 21H
JMP DONE             ; Jump to DONE

IS_A:
; If input is 'A' or 'a', print "ENTER CHARACTER IS A"
LEA DX, MSG2
MOV AH, 9
INT 21H
JMP DONE             ; Jump to DONE

IS_aa:
; If input is 'A' or 'a', print "ENTER CHARACTER IS a"
LEA DX, MSG3
MOV AH, 9
INT 21H
JMP DONE             ; Jump to DONE


DONE:
MOV AH, 4CH             ; Exit the program
INT 21H

MAIN ENDP
END MAIN
