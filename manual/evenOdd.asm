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