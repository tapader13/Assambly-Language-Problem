include 'emu8086.inc'
.model small
.stack 100h

.data
    msg1 db 'Enter a string: $'
    msg2 db 0Dh, 0Ah, 'Number of Vowels: $'
    msg3 db 0Dh, 0Ah, 'Number of Consonants: $'
    string db 30 dup('$')  ; Buffer for input string (max 30 characters)
    
    vowels_count db 0
    consonants_count db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Print "Enter a string:"
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    ; Take string input
    mov si, offset string

input_loop:
    mov ah, 01h  ; DOS interrupt to take character input
    int 21h
    cmp al, 0Dh  ; Check if Enter is pressed
    je done_input
    mov [si], al ; Store input character in buffer
    inc si
    call check_char  ; Call function to check if vowel/consonant
    jmp input_loop

done_input:
    ; Print new line and "Number of Vowels:"
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    ; Print vowel count
    mov al, vowels_count
    call print_number

    ; Print new line and "Number of Consonants:"
    mov dx, offset msg3
    mov ah, 09h
    int 21h

    ; Print consonant count
    mov al, consonants_count
    call print_number

    mov ah, 4Ch
    int 21h  ; Exit program

main endp

; -----------------------------------
; Check if character is a vowel or consonant
; -----------------------------------
check_char proc
    ; Check if it's a vowel (a, e, i, o, u)
    cmp al, 'a'
    je is_vowel
    cmp al, 'e'
    je is_vowel
    cmp al, 'i'
    je is_vowel
    cmp al, 'o'
    je is_vowel
    cmp al, 'u'
    je is_vowel

    ; Check if it's a vowel (A, E, I, O, U)
    cmp al, 'A'
    je is_vowel
    cmp al, 'E'
    je is_vowel
    cmp al, 'I'
    je is_vowel
    cmp al, 'O'
    je is_vowel
    cmp al, 'U'
    je is_vowel

    ; If not a vowel, check if it's a letter (consonant)
    cmp al, 'A'
    jl not_letter
    cmp al, 'Z'
    jle is_consonant
    cmp al, 'a'
    jl not_letter
    cmp al, 'z'
    jg not_letter

is_consonant:
    inc consonants_count  ; Increment consonant count
    ret

is_vowel:
    inc vowels_count  ; Increment vowel count
    ret

not_letter:
    ret
check_char endp

; -----------------------------------
; Print a number (AL contains value)
; -----------------------------------
print_number proc
    ; Handle single-digit numbers
    cmp al, 10
    jb single_digit

    ; Handle two-digit numbers
    aam         ; Convert AL to ASCII (AH = tens, AL = units)
    add ax, 3030h ; Convert to ASCII
    mov dl, ah   ; Print tens digit
    mov ah, 02h
    int 21h
    mov dl, al   ; Print units digit
    int 21h
    ret

single_digit:
    add al, '0'  ; Convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h
    ret
print_number endp

end main