.model small
.stack 100h

.data
    inputMsg db 'Enter a string: $'
    outputMsg db 13, 10, 'Converted string: $'
    inputBuffer db 80, 0, 80 dup('$') ; Input buffer for up to 80 characters

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Display input message
    mov ah, 9                  ; Function 09h - Display string
    lea dx, inputMsg           ; Load address of input message
    int 21h

    ; Read input string
    mov ah, 0Ah                ; Function 0Ah - Buffered input
    lea dx, inputBuffer        ; Load address of input buffer
    int 21h

    ; Convert the case of characters
    lea si, inputBuffer + 2    ; Skip the first two bytes (size and current length)
    mov cl, inputBuffer[1]     ; Get the number of characters entered
convert_loop:
    cmp cl, 0                  ; Check if all characters are processed
    je conversion_done         ; Exit loop if done
    mov al, [si]               ; Load the current character
    cmp al, 'A'                ; Check if it's uppercase
    jb check_lower             ; Skip if less than 'A'
    cmp al, 'Z'                ; Check if it's greater than 'Z'
    ja check_lower             ; Skip if greater than 'Z'
    add al, 32                 ; Convert to lowercase
    jmp store_char             ; Store the result

check_lower:
    cmp al, 'a'                ; Check if it's lowercase
    jb store_char              ; Skip if less than 'a'
    cmp al, 'z'                ; Check if it's greater than 'z'
    ja store_char              ; Skip if greater than 'z'
    sub al, 32                 ; Convert to uppercase

store_char:
    mov [si], al               ; Store the converted character
    inc si                     ; Move to the next character
    dec cl                     ; Decrease the counter
    jmp convert_loop           ; Repeat the loop

conversion_done:
    ; Display output message
    mov ah, 9                  ; Function 09h - Display string
    lea dx, outputMsg          ; Load address of output message
    int 21h

    ; Display the converted string
    lea dx, inputBuffer + 2    ; Skip the first two bytes for display
    mov ah, 9                  ; Function 09h - Display string
    int 21h

    ; Exit program
    mov ah, 4Ch                ; Function 4Ch - Terminate program
    int 21h
main endp
end main
