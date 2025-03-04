include 'emu8086.inc'  ; Required for input/output functions
.model small
.stack 100h

.data
    prompt_msg db 'Enter a single-digit number (1-3): $'
    error_msg db 0Dh, 0Ah, 'Invalid input! Please enter 1, 2, or 3. $'
    result_msg db 0Dh, 0Ah, 'Summation result: $'
    newline db 0Dh, 0Ah, '$'
    num db ?        ; Store input number
    sum db 0        ; Store calculated sum

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display input prompt message
    mov dx, offset prompt_msg
    mov ah, 09h
    int 21h

    ; Read input character
    mov ah, 01h
    int 21h
    sub al, '0'    ; Convert ASCII to integer
    cmp al, 1
    jl invalid_input  ; If less than 1, invalid
    cmp al, 3
    jg invalid_input  ; If greater than 3, invalid
    mov num, al       ; Store valid number

    ; Compute summation (1 + 2 + ... + N)
    xor ax, ax        ; Clear AX
    mov cl, num       ; Load N into CL
    mov ch, 0         ; Clear CH for loop counter
sum_loop:
    add al, cl        ; Add current number to sum
    loop sum_loop     ; Repeat until CL reaches 0
    mov sum, al       ; Store final sum

    ; Display result message
    mov dx, offset result_msg
    mov ah, 09h
    int 21h

    ; Convert sum to ASCII and display
    mov al, sum
    aam               ; Convert to two-digit ASCII (for numbers 1-6)
    add ax, 3030h     ; Convert digits to ASCII
    mov dl, ah        ; Get tens place
    cmp dl, '0'       ; Check if leading zero
    je skip_tens
    mov ah, 02h       ; Print tens place
    int 21h
skip_tens:
    mov dl, al        ; Get ones place
    mov ah, 02h       ; Print ones place
    int 21h

    ; Print newline
    mov dx, offset newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

invalid_input:
    ; Display error message
    mov dx, offset error_msg
    mov ah, 09h
    int 21h
    jmp main          ; Restart program

main endp
end main
