include 'emu8086.inc'
.model small
.stack 100h

.data
    str1 db 'Hello, World!$'   ; Main string to search in
    str2 db 'World$'           ; Substring to search for
    found_msg db 'Substring found!$'
    not_found_msg db 'Substring not found!$'

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax              ; Set ES to DS for string operations

    ; Point SI to the main string (str1)
    lea si, str1

    ; Point DI to the substring (str2)
    lea di, str2

search_loop:
    ; Compare the current character of str1 with the first character of str2
    mov al, [si]            ; Load current character of str1
    cmp al, '$'             ; Check if end of str1
    je not_found            ; If end of str1, substring not found
    cmp al, [di]            ; Compare with first character of str2
    je check_substring      ; If match, check the rest of the substring
    inc si                  ; Move to the next character in str1
    jmp search_loop         ; Continue searching

check_substring:
    ; Save current positions of SI and DI
    push si
    push di

compare_loop:
    inc si                  ; Move to the next character in str1
    inc di                  ; Move to the next character in str2
    mov al, [si]            ; Load next character of str1
    mov bl, [di]            ; Load next character of str2
    cmp bl, '$'             ; Check if end of str2
    je found                ; If end of str2, substring found
    cmp al, bl              ; Compare characters of str1 and str2
    jne mismatch            ; If mismatch, continue searching
    jmp compare_loop        ; Continue comparing

mismatch:
    ; Restore positions of SI and DI
    pop di
    pop si
    inc si                  ; Move to the next character in str1
    jmp search_loop         ; Continue searching

found:
    ; Print success message
    lea dx, found_msg
    mov ah, 09h
    int 21h
    jmp exit

not_found:
    ; Print failure message
    lea dx, not_found_msg
    mov ah, 09h
    int 21h

exit:
    ; Exit program
    mov ah, 4Ch
    int 21h
main endp

end main