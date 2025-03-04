include 'emu8086.inc'
.model small
.stack 100h

.data
    prompt1 db 'Enter the main string: $'
    prompt2 db 0Dh, 0Ah, 'Enter the substring to search: $'
    found_msg db 0Dh, 0Ah, 'Substring found!$'
    not_found_msg db 0Dh, 0Ah, 'Substring not found!$'
    str1 db 100 dup('$')   ; Buffer for main string (max 100 characters)
    str2 db 100 dup('$')   ; Buffer for substring (max 100 characters)

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax              ; Set ES to DS for string operations

    ; Prompt for main string
    lea dx, prompt1
    mov ah, 09h
    int 21h

    ; Read main string from user
    lea di, str1
    call read_string

    ; Prompt for substring
    lea dx, prompt2
    mov ah, 09h
    int 21h

    ; Read substring from user
    lea di, str2
    call read_string

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

; -----------------------------------
; Procedure to read a string from user
; Input: DI = address of buffer to store string
; -----------------------------------
read_string proc
    mov cx, 0               ; Counter for string length
read_loop:
    mov ah, 01h             ; DOS interrupt to read a character
    int 21h
    cmp al, 0Dh             ; Check if Enter is pressed
    je done_read            ; If Enter, finish reading
    stosb                   ; Store character in buffer, increment DI
    inc cx                  ; Increment length counter
    jmp read_loop           ; Continue reading
done_read:
    mov al, '$'             ; Add null terminator
    stosb
    ret
read_string endp

end main