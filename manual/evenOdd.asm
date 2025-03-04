include 'emu8086.inc'
.model small
.stack 100h

.data
    prompt db 'Enter a single-digit number (0-9): $'
    even_msg db 0Dh, 0Ah, 'The number is even.$'
    odd_msg db 0Dh, 0Ah, 'The number is odd.$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display prompt to enter a number
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read a single-digit number from the user
    mov ah, 01h  ; DOS interrupt to read a character
    int 21h
    sub al, '0'  ; Convert ASCII to binary (0-9)

    ; Check if the number is even or odd
    test al, 1   ; Test the least significant bit (LSB)
    jz is_even   ; If LSB is 0, the number is even

    ; If the number is odd
    lea dx, odd_msg
    jmp display_result

is_even:
    ; If the number is even
    lea dx, even_msg

display_result:
    ; Display the result message
    mov ah, 09h
    int 21h

    ; Exit the program
    mov ah, 4Ch
    int 21h
main endp

end main




include 'emu8086.inc'
.model small
.stack 100h

.data
    prompt db 'Enter a single-digit number (0-9): $'
    even_msg db 0Dh, 0Ah, 'The number is even.$'
    odd_msg db 0Dh, 0Ah, 'The number is odd.$'
    invalid_msg db 0Dh, 0Ah, 'Invalid input. Please enter a number between 0 and 9.$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display prompt to enter a number
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read a single-digit number from the user
    mov ah, 01h  ; DOS interrupt to read a character
    int 21h
    sub al, '0'  ; Convert ASCII to binary (0-9)

    ; Check if the input is a valid digit (0-9)
    cmp al, 0    ; Compare input with '0'
    jl invalid_input
    cmp al, 9    ; Compare input with '9'
    jg invalid_input

    ; Check if the number is even or odd
    test al, 1   ; Test the least significant bit (LSB)
    jz is_even   ; If LSB is 0, the number is even

    ; If the number is odd
    lea dx, odd_msg
    jmp display_result

is_even:
    ; If the number is even
    lea dx, even_msg

display_result:
    ; Display the result message
    mov ah, 09h
    int 21h

    ; Exit the program
    mov ah, 4Ch
    int 21h

invalid_input:
    ; Display the invalid input message
    lea dx, invalid_msg
    mov ah, 09h
    int 21h

    ; Exit the program
    mov ah, 4Ch
    int 21h

main endp

end main
