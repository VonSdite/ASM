ASSUME CS:CODE 

DATA SEGMENT
    DB 'welcome to masm!', '$'
DATA ENDS

CODE SEGMENT
    START:
        MOV AH, 2
        MOV BH, 0
        MOV DH, 23
        MOV DL, 12
        INT 10H

        MOV AX, DATA
        MOV DS, AX
        MOV DX, 0
        MOV AH, 9
        INT 21H

        MOV AX, 4C00H
        INT 21H
CODE ENDS
END START