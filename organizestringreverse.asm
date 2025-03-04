include 'emu8086.inc'
.model small
.stack 100h

.data
    msg1 db 'Enter a string: $'
    msg2 db 0Dh, 0Ah, 'Reversed string: $'
    string db 20 dup('$')  ; Buffer to store input (max 20 characters)

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Print "Enter a string:"
    lea dx, msg1
    mov ah, 9
    int 21h

    ; Take string input
    mov si, offset string  ; Point to string buffer
    mov cx, 0             ; Clear CX (counter)

input_loop:
    mov ah, 01h           ; DOS interrupt for single character input
    int 21h               ; Read character into AL
    cmp al, 0Dh           ; Check if Enter (Carriage Return) is pressed
    je done_input         ; If Enter, stop input
    mov [si], al          ; Store character in string buffer
    push ax               ; Push character onto stack
    inc si                ; Move to next buffer location
    inc cx                ; Increase character count
    jmp input_loop        ; Repeat

done_input:
    ; Print new line and "Reversed string:"
    mov dx, offset msg2
    mov ah, 09h
    int 21h

reverse_loop:
    pop dx                ; Pop character from stack (LIFO order)
    mov ah, 02h           ; DOS interrupt to print character
    int 21h
    loop reverse_loop     ; Repeat for all characters

    mov ah, 4Ch           ; Exit program
    int 21h

main endp
end main
