INCLUDE 'emu8086.inc'
.MODEL SMALL
.STACK 100H

.DATA
    prompt DB 'Enter a word (all uppercase or all lowercase): $'
    asc_msg DB 0Dh, 0Ah, 'Sorted in Ascending Order: $'
    desc_msg DB 0Dh, 0Ah, 'Sorted in Descending Order: $'
    word DB 100 DUP('$')    ; Buffer to store the input word
    sorted DB 100 DUP('$')  ; Buffer to store the sorted word

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display input prompt
    LEA DX, prompt
    MOV AH, 09h
    INT 21h

    ; Read the word
    LEA DI, word
    CALL READ_STRING

    ; Copy word to sorted buffer
    LEA SI, word
    LEA DI, sorted
    CALL COPY_STRING

    ; Sort in ascending order
    CALL SORT_ASCENDING

    ; Display ascending order message
    LEA DX, asc_msg
    MOV AH, 09h
    INT 21h

    ; Display sorted word
    LEA DX, sorted
    MOV AH, 09h
    INT 21h

    ; Copy original word again for descending order
    LEA SI, word
    LEA DI, sorted
    CALL COPY_STRING

    ; Sort in descending order
    CALL SORT_DESCENDING

    ; Display descending order message
    LEA DX, desc_msg
    MOV AH, 09h
    INT 21h

    ; Display sorted word
    LEA DX, sorted
    MOV AH, 09h
    INT 21h

    ; Exit program
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; -----------------------------------
; Read string from user
; Input: DI = address of buffer
; -----------------------------------
READ_STRING PROC
    MOV CX, 0  ; Counter for string length
READ_LOOP:
    MOV AH, 01h  ; DOS interrupt to read a character
    INT 21h
    CMP AL, 0Dh  ; Check if Enter is pressed
    JE DONE_READ
    MOV [DI], AL ; Store character in buffer
    INC DI       ; Increment DI
    INC CX       ; Increment length counter
    JMP READ_LOOP
DONE_READ:
    MOV AL, '$'  ; Add null terminator
    MOV [DI], AL
    RET
READ_STRING ENDP

; -----------------------------------
; Copy string from SI to DI
; -----------------------------------
COPY_STRING PROC
COPY_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    CMP AL, '$'
    JE DONE_COPY
    INC SI
    INC DI
    JMP COPY_LOOP
DONE_COPY:
    RET
COPY_STRING ENDP

; -----------------------------------
; Sort string in ascending order (Bubble Sort)
; Input: sorted[]
; -----------------------------------
SORT_ASCENDING PROC
    LEA SI, sorted
    MOV CX, 0  ; Initialize counter
COUNT_LENGTH:
    CMP BYTE PTR [SI], '$'
    JE END_COUNT
    INC CX
    INC SI
    JMP COUNT_LENGTH
END_COUNT:
    DEC CX  ; Length of string (excluding '$')

    ; Bubble Sort
    MOV BX, CX  ; Outer loop counter
OUTER_LOOP_ASC:
    LEA SI, sorted
    MOV CX, BX  ; Inner loop counter
INNER_LOOP_ASC:
    MOV AL, [SI]
    CMP AL, [SI+1]
    JBE NO_SWAP_ASC
    XCHG AL, [SI+1]
    MOV [SI], AL
NO_SWAP_ASC:
    INC SI
    LOOP INNER_LOOP_ASC
    DEC BX
    JNZ OUTER_LOOP_ASC
    RET
SORT_ASCENDING ENDP

; -----------------------------------
; Sort string in descending order (Bubble Sort)
; Input: sorted[]
; -----------------------------------
SORT_DESCENDING PROC
    LEA SI, sorted
    MOV CX, 0  ; Initialize counter
COUNT_LENGTH_DESC:
    CMP BYTE PTR [SI], '$'
    JE END_COUNT_DESC
    INC CX
    INC SI
    JMP COUNT_LENGTH_DESC
END_COUNT_DESC:
    DEC CX  ; Length of string (excluding '$')

    ; Bubble Sort
    MOV BX, CX  ; Outer loop counter
OUTER_LOOP_DESC:
    LEA SI, sorted
    MOV CX, BX  ; Inner loop counter
INNER_LOOP_DESC:
    MOV AL, [SI]
    CMP AL, [SI+1]
    JAE NO_SWAP_DESC
    XCHG AL, [SI+1]
    MOV [SI], AL
NO_SWAP_DESC:
    INC SI
    LOOP INNER_LOOP_DESC
    DEC BX
    JNZ OUTER_LOOP_DESC
    RET
SORT_DESCENDING ENDP

END MAIN