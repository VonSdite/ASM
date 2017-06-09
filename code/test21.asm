ASSUME CS:CODE

DATA SEGMENT
    DB 'conversation', 0
DATA ENDS

CODE SEGMENT
    START:
        MOV AX, DATA
        MOV DS, AX
        MOV SI, 0
        INT 7CH
        CALL SHOW

        MOV AX, 4C00H
        INT 21H

    SHOW:
        PUSH AX
        PUSH ES
        PUSH DI
        PUSH SI

        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 12*160+39*2

        S:
            CMP BYTE PTR DS:[SI], 0
            JE OK
            MOV AL, BYTE PTR DS:[SI]
            MOV ES:[DI], AL
            MOV BYTE PTR ES:[DI+1], 2
            ADD DI, 2
            INC SI
            JMP SHORT S
        OK:
            POP SI
            POP DI
            POP ES
            POP AX
            RET

CODE ENDS
END START