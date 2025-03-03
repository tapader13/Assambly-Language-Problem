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


; .MODEL SMALL
; .STACK 100H
; .DATA
; .CODE
; MAIN PROC

;     MOV AH, 1       ; Take input (single character)
;     INT 21H
;     MOV BL, AL      ; Store input character

;     MOV AH, 2       ; Print original character
;     MOV DL, BL
;     INT 21H

;     ; CHECK IF LOWERCASE (a-z)
;     CMP BL, 61H     ; Compare with 'a'
;     JL CHECK_UPPER  ; If less than 'a', check uppercase
;     CMP BL, 7AH     ; Compare with 'z'
;     JG CHECK_UPPER  ; If greater than 'z', check uppercase

;     SUB BL, 20H     ; Convert lowercase to uppercase
;     JMP PRINT       ; Jump to printing converted character

; CHECK_UPPER:
;     CMP BL, 41H     ; Compare with 'A'
;     JL PRINT        ; If less than 'A', do nothing
;     CMP BL, 5AH     ; Compare with 'Z'
;     JG PRINT        ; If greater than 'Z', do nothing

;     ADD BL, 20H     ; Convert uppercase to lowercase

; PRINT:
;     ; PRINT CONVERTED CHARACTER
;     MOV AH, 2
;     MOV DL, BL
;     INT 21H

;     MOV AH, 4CH     ; Exit program
;     INT 21H

; MAIN ENDP
; END MAIN
