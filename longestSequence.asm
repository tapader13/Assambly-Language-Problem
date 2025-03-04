INCLUDE 'emu8086.inc'
.MODEL SMALL
.STACK 100H

.DATA
    prompt DB 'Enter a word (all uppercase or all lowercase): $'
    result_msg DB 0Dh, 0Ah, 'Longest sequence in alphabetical order: $'
    word DB 100 DUP('$')       ; Buffer to store the input word
    longest_seq DB 100 DUP('$') ; Buffer to store the longest sequence
    current_seq DB 100 DUP('$') ; Buffer to store the current sequence
    longest_len DB 0           ; Length of the longest sequence
    current_len DB 0           ; Length of the current sequence

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt the user to enter a word
    LEA DX, prompt
    MOV AH, 09h
    INT 21h

    ; Read the word from the user
    LEA DI, word
    CALL read_string

    ; Point SI to the beginning of the word
    LEA SI, word

    ; Initialize variables
    MOV longest_len, 0
    MOV current_len, 0
    LEA DI, current_seq
    LEA BX, longest_seq

FIND_SEQUENCE:
    MOV AL, [SI]            ; Load the current character
    CMP AL, '$'             ; Check if end of word
    JE DONE_FINDING         ; If end of word, finish finding

    ; Check if the current character is in alphabetical order with the previous character
    CMP current_len, 0      ; Check if this is the first character in the sequence
    JE ADD_TO_SEQUENCE      ; If yes, add it to the sequence
    MOV DL, [DI-1]          ; Load the previous character in the sequence
    CMP AL, DL              ; Compare current character with the previous character
    JAE ADD_TO_SEQUENCE     ; If current character >= previous character, add to sequence

    ; If not in order, compare current sequence with longest sequence
    MOV CL, current_len     ; Load current_len into CL
    CMP CL, longest_len     ; Compare current_len with longest_len
    JBE RESET_SEQUENCE      ; If current sequence is not longer, reset it

    ; Update longest sequence
    MOV longest_len, CL     ; Update longest sequence length
    LEA SI, current_seq
    LEA DI, longest_seq
    MOV CH, CL              ; Save length in CH

COPY_LONGEST:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    DEC CH
    JNZ COPY_LONGEST

RESET_SEQUENCE:
    ; Reset current sequence
    MOV current_len, 0
    LEA DI, current_seq

ADD_TO_SEQUENCE:
    ; Add the current character to the current sequence
    MOV [DI], AL
    INC DI
    INC current_len
    INC SI                  ; Move to the next character
    JMP FIND_SEQUENCE       ; Continue finding

DONE_FINDING:
    ; Check if the last sequence is the longest
    MOV CL, current_len     ; Load current_len into CL
    CMP CL, longest_len     ; Compare current_len with longest_len
    JBE DISPLAY_RESULT

    ; Update longest sequence
    MOV longest_len, CL
    LEA SI, current_seq
    LEA DI, longest_seq
    MOV CH, CL              ; Save length in CH

COPY_LAST:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    DEC CH
    JNZ COPY_LAST

    MOV BYTE PTR [DI], '$'  ; Ensure string is terminated

DISPLAY_RESULT:
    ; Display the result message
    LEA DX, result_msg
    MOV AH, 09h
    INT 21h

    ; Display the longest sequence
    LEA DX, longest_seq
    MOV AH, 09h
    INT 21h

    ; Exit the program
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; -----------------------------------
; Procedure to read a string from the user
; Input: DI = address of the buffer to store the string
; -----------------------------------
READ_STRING PROC
    MOV CX, 0               ; Counter for string length
READ_LOOP:
    MOV AH, 01h             ; DOS interrupt to read a character
    INT 21h
    CMP AL, 0Dh             ; Check if Enter is pressed
    JE DONE_READ            ; If Enter, finish reading
    MOV [DI], AL            ; Store character in buffer
    INC DI                  ; Increment DI
    INC CX                  ; Increment length counter
    JMP READ_LOOP           ; Continue reading
DONE_READ:
    MOV AL, '$'             ; Add null terminator
    MOV [DI], AL
    RET
READ_STRING ENDP

END MAIN
