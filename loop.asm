include 'emu8086.inc'
.model small
.stack 100h
.data
    array db 3,5,6,7,9,1

.code
main proc
    mov ax, @data
    mov ds, ax

    mov si, offset array
    mov cx, 6

    print 'Your Array Values :'

loopx:
    mov dl, [si]     ; Load value from array into DL
    add dl, 48       ; Convert number to ASCII

    mov ah, 02h      ; DOS interrupt for printing character
    int 21h

    mov dl, 32       ; Print space
    mov ah, 02h
    int 21h

    inc si           ; Move to the next element
    loop loopx       ; Loop until CX becomes zero

    mov ah, 04ch     ; Terminate program
    int 21h

main endp
end main
