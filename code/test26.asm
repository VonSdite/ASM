ASSUME CS:CODE 

STACK SEGMENT
    DW 16 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 20H
        
        MOV AL, 160
        MOV DH, 10
        MUL DH

        MOV AX, 4C00H
        INT 21H

CODE ENDS
END START