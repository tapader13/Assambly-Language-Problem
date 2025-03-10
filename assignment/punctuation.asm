.MODEL SMALL
.STACK 100H

.DATA
    inputMsg DB 'Enter a string: $'
    outputMsg DB 'Number of punctuation symbols: $'
    newline DB 13, 10, '$'
    buffer DB 100 DUP('$')

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, inputMsg
    MOV AH, 09H
    INT 21H

    LEA DX, buffer
    MOV AH, 0AH
    INT 21H

    MOV CX, 0
    LEA SI, buffer + 2

COUNT_LOOP:
    MOV AL, [SI]
    CMP AL, '$'
    JE END_COUNT

    CMP AL, '!'
    JE INCREMENT
    CMP AL, ','
    JE INCREMENT
    CMP AL, '.'
    JE INCREMENT
    CMP AL, ';'
    JE INCREMENT
    CMP AL, ':'
    JE INCREMENT
    CMP AL, '?'
    JE INCREMENT
    CMP AL, '"'
    JE INCREMENT
    CMP AL, '('
    JE INCREMENT
    CMP AL, ')'
    JE INCREMENT
    CMP AL, '['
    JE INCREMENT
    CMP AL, ']'
    JE INCREMENT
    CMP AL, '{'
    JE INCREMENT
    CMP AL, '}'
    JE INCREMENT
    CMP AL, '-'
    JE INCREMENT
    CMP AL, '/'
    JE INCREMENT

    JMP NEXT_CHAR

INCREMENT:
    INC CX

NEXT_CHAR:
    INC SI
    JMP COUNT_LOOP

END_COUNT:
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    LEA DX, outputMsg
    MOV AH, 09H
    INT 21H

    MOV AX, CX
    CALL PRINT_NUMBER

    MOV AH, 4CH
    INT 21H

MAIN ENDP

PRINT_NUMBER PROC
    MOV CX, 0
    MOV BX, 10

CONVERT_LOOP:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_LOOP

    RET
PRINT_NUMBER ENDP

END MAIN
