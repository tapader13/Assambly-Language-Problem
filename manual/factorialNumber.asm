; Factorial Calculation (Single Digit 0-3) - 8086 Assembly

.MODEL SMALL
.STACK 100H

.DATA
    prompt DB 'Enter a single digit (0-3): ', '$'
    result_msg DB 'Factorial of ', '$'
    equals_msg DB ' = ', '$'
    invalid_msg DB 'Invalid input.', 0DH, 0AH, '$'
    factorial_values DW 1, 1, 2, 6 ; Factorials of 0, 1, 2, 3

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt
    MOV AH, 09H
    LEA DX, prompt
    INT 21H

    ; Read input character
    MOV AH, 01H
    INT 21H

    ; Check for valid input (0-3)
    CMP AL, '0'
    JL invalid
    CMP AL, '3'
    JG invalid

    ; Convert ASCII to number
    SUB AL, '0'
    MOV BL, AL ; Store number in BL

    ; Display "Factorial of " message
    MOV AH, 09H
    LEA DX, result_msg
    INT 21H

    ; Display the input number
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    ; Display " = " message
    MOV AH, 09H
    LEA DX, equals_msg
    INT 21H

    ; Calculate factorial
    MOV AL, BL
    MOV AH, 0
    MOV BX, OFFSET factorial_values
    ADD BX, AX ; BX = factorial_values + AL
    ADD BX, AX ; BX = factorial_values + 2 * AL
    MOV AX, [BX] ; AX = factorial_values[AL]

    ; Display factorial result (AX)
    PUSH AX
    CALL display_number
    ADD SP, 2 ; clean stack

    JMP exit

invalid:
    ; Display invalid input message
    MOV AH, 09H
    LEA DX, invalid_msg
    INT 21H

exit:
    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Subroutine to display a number in AX
display_number PROC
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    MOV CX, 0

convert_loop:
    MOV DX, 0
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE convert_loop

display_loop:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP display_loop

    POP DX
    POP CX
    POP BX
    RET
display_number ENDP

END MAIN