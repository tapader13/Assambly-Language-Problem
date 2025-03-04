.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC

MOV AH, 1 ;TAKE INPUT
INT 21H
MOV BL, AL

MOV AH, 2 ;TAKE OUTPUT
MOV DL, BL
INT 21H

CMP BL, 61H
JL LOWERCASE
CMP BL, 7AH
JG LOWERCASE
SUB BL, 20H
LOWERCASE:
ADD BL, 20H

MOV AH, 2 ;TAKE OUTPUT
MOV DL, BL
INT 21H

MOV AH, 4CH
INT 21H
MAIN ENDP
END MAIN


.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC

    MOV AH, 1       ; Take input (single character)
    INT 21H
    MOV BL, AL      ; Store input character

    MOV AH, 2       ; Print original character
    MOV DL, BL
    INT 21H

    ; CHECK IF LOWERCASE (a-z)
    CMP BL, 61H     ; Compare with 'a'
    JL CHECK_UPPER  ; If less than 'a', check uppercase
    CMP BL, 7AH     ; Compare with 'z'
    JG CHECK_UPPER  ; If greater than 'z', check uppercase

    SUB BL, 20H     ; Convert lowercase to uppercase
    JMP PRINT       ; Jump to printing converted character

CHECK_UPPER:
    CMP BL, 41H     ; Compare with 'A'
    JL PRINT        ; If less than 'A', do nothing
    CMP BL, 5AH     ; Compare with 'Z'
    JG PRINT        ; If greater than 'Z', do nothing

    ADD BL, 20H     ; Convert uppercase to lowercase

PRINT:
    ; PRINT CONVERTED CHARACTER
    MOV AH, 2
    MOV DL, BL
    INT 21H

    MOV AH, 4CH     ; Exit program
    INT 21H

MAIN ENDP
END MAIN

;actual code acroding to assignment

.MODEL SMALL
.STACK 100H
.DATA
CR EQU 0DH
LF EQU 0AH
MSG1 DB 'Enter a string:',CR,LF, '$'
MSG2 DB CR,LF,'In opposite case it is:',CR,LF, '$'
X DB 100 DUP(?)        ; Buffer to store the converted string
.CODE

MAIN PROC
    MOV AX, @DATA       ; Initialize the Data Segment
    MOV DS, AX

    ; Display input prompt
    LEA DX, MSG1        ; Load address of MSG1 into DX
    MOV AH, 09H         ; DOS interrupt to display a string
    INT 21H

    MOV SI, 0           ; Initialize SI to 0 (index for X array)
    MOV AH, 01H         ; DOS interrupt to read a character from input

NEXT1:
    INT 21H             ; Call DOS interrupt to get input character
    CMP AL, CR          ; Compare input character with carriage return (CR)
    JE EXIT             ; If CR, exit the loop (end of input)

    ; Convert uppercase to lowercase
    CMP AL, 'A'         ; If AL >= 'A'
    JL SKIP2            ; Jump to SKIP2 if less than 'A'
    CMP AL, 'Z'         ; If AL <= 'Z'
    JG SKIP1            ; Jump to SKIP1 if greater than 'Z'
    ADD AL, 20H         ; Convert to lowercase by adding 20H
    JMP SKIP2           ; Jump to SKIP2

SKIP1:
    ; Convert lowercase to uppercase
    CMP AL, 'a'         ; If AL >= 'a'
    JL SKIP2            ; Jump to SKIP2 if less than 'a'
    CMP AL, 'z'         ; If AL <= 'z'
    JG SKIP2            ; Jump to SKIP2 if greater than 'z'
    SUB AL, 20H         ; Convert to uppercase by subtracting 20H

SKIP2:
    MOV X[SI], AL       ; Store the character in X array
    INC SI              ; Increment SI (move to the next index)
    JMP NEXT1           ; Repeat the loop

EXIT:
    ; Display output prompt
    LEA DX, MSG2        ; Load address of MSG2 into DX
    MOV AH, 09H         ; DOS interrupt to display a string
    INT 21H

    MOV AH, 02H         ; DOS interrupt to display a character
    MOV DI, 0           ; Initialize DI to 0 (index for X array)

NEXT2:
    MOV DL, X[DI]       ; Load the character from X array into DL
    INT 21H             ; Call DOS interrupt to display the character
    INC DI              ; Increment DI (move to the next index)
    CMP DI, SI          ; Compare DI with SI (check if we've printed all characters)
    JNE NEXT2           ; If DI != SI, repeat the loop

    MOV AH, 4CH         ; Exit program
    INT 21H

MAIN ENDP
END MAIN
