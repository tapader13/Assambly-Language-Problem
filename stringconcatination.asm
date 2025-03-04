include 'emu8086.inc'
.model small
.stack 100h

.data
    str1 db 'Hello, $'      ; First string (ends with $)
    str2 db 'World!$'       ; Second string (ends with $)
    result db 50 dup('$')   ; Buffer to store concatenated result

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax              ; Set ES to DS for string operations

    ; Point SI to the first string (str1)
    lea si, str1

    ; Point DI to the result buffer
    lea di, result

    ; Copy str1 to result
copy_str1:
    lodsb                   ; Load byte from [SI] into AL, increment SI
    cmp al, '$'             ; Check if end of str1
    je copy_str2            ; If end of str1, start copying str2
    stosb                   ; Store AL into [DI], increment DI
    jmp copy_str1           ; Continue copying str1

copy_str2:
    ; Point SI to the second string (str2)
    lea si, str2

    ; Copy str2 to result
copy_str2_loop:
    lodsb                   ; Load byte from [SI] into AL, increment SI
    cmp al, '$'             ; Check if end of str2
    je done                 ; If end of str2, finish
    stosb                   ; Store AL into [DI], increment DI
    jmp copy_str2_loop      ; Continue copying str2

done:
    ; Print the concatenated result
    lea dx, result
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp

end main