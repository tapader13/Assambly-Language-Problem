.MODEL SMALL
.STACK 100H 
.DATA 
.CODE

MAIN PROC 

; FOR TAKE INPUT
 MOV AH, 1 ;TAKE INPUT
 INT 21H  
 MOV BL, AL
 INT 21H
 MOV CL, AL

; FOR NEW LINE
MOV AH, 2 
MOV DL, 0DH ;CARRIAGE RETURN
INT 21H
MOV DL, 0AH ;NEW LINE
INT 21H

; FOR SUB OF INPUT
 SUB BL, CL
 ADD BL, 48

; FOR TAKE OUTPUT
 MOV AH, 2 ;TAKE OUTPUT
 MOV DL, BL
 INT 21H


; FOR EXIT
 MOV AH, 4CH
 INT 21H
MAIN ENDP

END MAIN