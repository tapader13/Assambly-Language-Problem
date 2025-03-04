include 'emu8086.inc'
.model small
.stack 100h

.data
    string db 'mdjamalmca'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov si, offset string
    mov cx, 10  ; Length of the string

loop1:
    mov bx, [si]  ; Load character from the string
    push bx       ; Push it onto the stack
    inc si        ; Move to the next character
    loop loop1    ; Repeat for all characters

    mov cx, 10    ; Reset loop counter for popping and printing

loop2:
    pop dx        ; Pop character from stack (LIFO order)
    mov ah, 02h   ; DOS interrupt for printing character
    int 21h       ; Print the character
    loop loop2    ; Repeat for all characters

    main endp
end main



include 'emu8086.inc'

.model small
.stack 100h
.data
    msg1 db 'Enter a string: $'   ; Prompt message
    msg2 db 10, 13, 'Reversed string: $'  ; New line and message
    buffer db 20  ; Max input length
    length db ?   ; Actual length of input
    input db 20 dup('$') ; Buffer to store input characters

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display message to enter string
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    ; Take user input
    mov dx, offset buffer
    mov ah, 0Ah
    int 21h

    ; Print newline and reversed string message
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    ; Get input length
    mov cl, length   ; Store actual length in CL
    mov ch, 0        ; Clear CH to use CX as loop counter

    ; Initialize SI to the start of input buffer
    mov si, offset input

store_chars:
    mov al, [si]  ; Load character from input buffer
    push ax       ; Push it onto the stack
    inc si        ; Move to next character
    loop store_chars

    ; Print reversed string
    mov cl, length
    mov ch, 0

print_reverse:
    pop dx        ; Get last stored character
    mov ah, 02h   ; DOS interrupt to print character
    int 21h
    loop print_reverse

    ; Terminate program
    mov ah, 4Ch
    int 21h

main endp
end main
