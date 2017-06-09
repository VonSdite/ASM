ASSUME CS:CODE 

STACK SEGMENT
    DW 16 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 20H

        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 8*160
        MOV AL, 10H
        MOV CX, 7
        S0:
            PUSH CX
            MOV CX, 16
            MOV BX, 20*2
            S1:
                MOV BYTE PTR ES:[DI+BX], AL
                MOV BYTE PTR ES:[DI+BX+1], 7
                MOV BYTE PTR ES:[DI+BX+2], ' '
                MOV BYTE PTR ES:[DI+BX+3], 7
                INC AL
                ADD BX, 4
            LOOP S1
            ADD DI, 0A0H
            POP CX
        LOOP S0
        MOV AX, 4C00H
        INT 21H
CODE ENDS
END START
