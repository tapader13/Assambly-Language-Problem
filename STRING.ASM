; .MODEL SMALL
; .STACK 100H 
; .DATA 
; STRING1 DB "HELLO WORLD 1 $"
; STRING2 DB "HELLO WORLD 2 $"
; .CODE

; MAIN PROC 

; ; DATA INITIALIZE
; MOV AX, @DATA
; MOV DS, AX

; ; STRING SHOW
; LEA DX STRING1
; MOV AH, 9
; INT 21H 

; ; FOR NEW LINE
; MOV AH, 2 
; MOV DL, 0DH ;CARRIAGE RETURN
; INT 21H
; MOV DL, 0AH ;NEW LINE
; INT 21H

; ; STRING SHOW
; LEA DX STRING2
; MOV AH, 9
; INT 21H


; ; FOR EXIT
;  MOV AH, 4CH
;  INT 21H
; MAIN ENDP

; END MAIN


.MODEL SMALL
.STACK 100H

.DATA
before_msg DB "Before Swapping: $"
after_msg DB "After Swapping: $"

.CODE
MAIN PROC

MOV AX, @DATA
 MOV DS, AX
    ; Display "Before Swapping" message
    LEA DX, before_msg     ; Load address of 'Before Swapping' message
    MOV AH, 9           ; DOS function to display a string
    INT 21H                ; Call DOS interrupt

    ; Take first input
    MOV AH, 1              ; DOS function to take input
    INT 21H                ; Get input character
    MOV BL, AL             ; Store the input in BL

    ; Display first input
    MOV AH, 02H            ; DOS function to display a character
    MOV DL, BL             ; Load the first input character into DL
    INT 21H                ; Call DOS interrupt to display the character

    ; Take second input
    MOV AH, 1              ; DOS function to take input
    INT 21H                ; Get input character
    MOV CL, AL             ; Store the second input in CL

    ; Display second input
    MOV AH, 02H            ; DOS function to display a character
    MOV DL, CL             ; Load the second input character into DL
    INT 21H                ; Call DOS interrupt to display the character

    ; Swap the values in BL and CL
    XCHG BL, CL            ; Exchange values between BL and CL

    ; Display newline for separation
    MOV AH, 02H            ; DOS function to print newline
    MOV DL, 0DH            ; Carriage return
    INT 21H
    MOV DL, 0AH            ; Line feed (newline)
    INT 21H

    ; Display "After Swapping" message
    MOV AH, 09H            ; DOS function to print string
    LEA DX, after_msg      ; Load address of 'After Swapping' message
    INT 21H                ; Call DOS interrupt

    ; Display swapped values
    MOV AH, 02H            ; DOS function to display a character

    ; Display swapped first character
    MOV DL, BL             ; Load swapped value from BL into DL
    INT 21H                ; Call DOS interrupt to display the character

    ; Display swapped second character
    MOV DL, CL             ; Load swapped value from CL into DL
    INT 21H                ; Call DOS interrupt to display the character

    ; Exit the program
    MOV AH, 4CH            ; DOS function to terminate the program
    INT 21H                ; Call DOS interrupt to exit
MAIN ENDP

END MAIN
