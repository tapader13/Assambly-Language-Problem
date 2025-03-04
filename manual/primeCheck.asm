.MODEL SMALL
.STACK 100H

.DATA
prompt DB 'Enter a number between 0 and 9: $'
primeMsg DB 'The number is prime.$'
notPrimeMsg DB 'The number is not prime.$'
invalidMsg DB 'Invalid input. Please enter a number between 0 and 9.$'
buffer DB 2     ; Buffer to store user input
num DB 0        ; To store the input number
i DB 0          ; Counter for checking divisibility
result DB 0     ; To store the result (prime or not)

.CODE
MAIN PROC
    MOV AX, @DATA       ; Initialize data segment
    MOV DS, AX

    ; Print prompt to enter a number
    MOV AH, 09H
    LEA DX, prompt
    INT 21H

    ; Read user input (single character)
    MOV AH, 01H         ; DOS function to read a single character from input
    INT 21H
    SUB AL, '0'         ; Convert ASCII to integer (e.g., '1' -> 1)
    MOV [num], AL       ; Store the input number

    ; Check if the number is within the valid range (0 to 9)
    CMP AL, 0
    JB  InvalidInput    ; If less than 0, jump to invalid input
    CMP AL, 9
    JA  InvalidInput    ; If greater than 9, jump to invalid input

    ; Check if the number is prime
    MOV AL, [num]       ; Load the input number into AL
    CMP AL, 0           ; Check if the number is 0
    JE  NotPrime        ; 0 is not prime, jump to NotPrime
    CMP AL, 1           ; Check if the number is 1
    JE  NotPrime        ; 1 is not prime, jump to NotPrime

    MOV BL, 2           ; Start checking from divisor 2
    MOV i, 2            ; Initialize counter i

checkDivisibility:
    MOV AL, [num]       ; Load number into AL
    MOV CL, i           ; Load the divisor (i) into CL
    MOV AH, 0           ; Clear AH before division
    DIV CL              ; AL / CL, quotient in AL, remainder in AH
    CMP AH, 0           ; If remainder is 0, it's divisible
    JE  NotPrime        ; If divisible, jump to NotPrime
    INC i               ; Increment the divisor
    CMP i, AL           ; Check if i >= number
    JAE Prime           ; If divisor is greater than or equal to number, it's prime
    JMP checkDivisibility

Prime:
    MOV AH, 09H
    LEA DX, primeMsg
    INT 21H
    JMP ExitProgram

NotPrime:
    MOV AH, 09H
    LEA DX, notPrimeMsg
    INT 21H
    JMP ExitProgram

InvalidInput:
    MOV AH, 09H
    LEA DX, invalidMsg
    INT 21H

ExitProgram:
    MOV AH, 4CH         ; Exit the program
    INT 21H

MAIN ENDP
END MAIN
