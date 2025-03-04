TITLE SINGLE_ADD
.MODEL SMALL
.STACK 100H
.DATA
    DIGIT1 DB 0AH, 0DH, "ENTER FIRST DIGIT: $"
    DIGIT2 DB 0AH, 0DH, "ENTER SECOND DIGIT: $"
    RESULT DB 0AH, 0DH, "RESULT IS $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt for the first digit
    LEA DX, DIGIT1
    MOV AH, 09H
    INT 21H

    ; Read the first digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'          ; Convert ASCII to binary
    MOV BL, AL           ; Store the first digit in BL

    ; Prompt for the second digit
    LEA DX, DIGIT2
    MOV AH, 09H
    INT 21H

    ; Read the second digit
    MOV AH, 01H
    INT 21H
    SUB AL, '0'          ; Convert ASCII to binary
    MOV BH, AL           ; Store the second digit in BH

    ; Add the two digits
    ADD BH, BL           ; BH = BH + BL

    ; Adjust the result using AAA (ASCII Adjust after Addition)
    MOV AL, BH           ; Move the sum to AL
    MOV AH, 00H          ; Clear AH
    AAA                  ; Adjust AL to unpacked BCD

    ; Store the result
    MOV BL, AL           ; Units digit
    MOV BH, AH           ; Tens digit

    ; Display the result message
    LEA DX, RESULT
    MOV AH, 09H
    INT 21H

    ; Display the tens digit (if any)
    MOV DL, BH
    ADD DL, '0'          ; Convert to ASCII
    MOV AH, 02H
    INT 21H

    ; Display the units digit
    MOV DL, BL
    ADD DL, '0'          ; Convert to ASCII
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN