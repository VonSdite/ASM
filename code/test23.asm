ASSUME CS:CODE 

DATA SEGMENT
    DB 'conversation', 0
DATA ENDS

CODE SEGMENT
    START:
        MOV AX, DATA
        MOV DS, AX
        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 160*12
        S:
            CMP BYTE PTR DS:[SI], 0
            JE OK
            MOV AL, DS:[SI]
            MOV ES:[DI], AL
            INC SI
            ADD DI, 2
            MOV BX, OFFSET S - OFFSET OK
            INT 7CH
        OK:
            MOV AX, 4C00H
            INT 21H
CODE ENDS
END START