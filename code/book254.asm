ASSUME CS:CODE

CODE SEGMENT
    START:
        MOV AX, CS
        MOV DS, AX
        MOV SI, OFFSET UPPERCASE 

        MOV AX, 0
        MOV ES, AX
        MOV DI, 200H

        MOV CX, OFFSET UPPERCASE_END - OFFSET UPPERCASE
        CLD
        REP MOVSB

        MOV WORD PTR ES:[7CH*4], 200H
        MOV WORD PTR ES:[7CH*4+2], 0

        MOV AX, 4C00H
        INT 21H

    UPPERCASE:
        PUSH SI
        UP:
            CMP BYTE PTR DS:[SI], 0
            JE OK
            AND BYTE PTR DS:[SI], 11011111B
            INC SI
            JMP SHORT UP
        OK:
            POP SI
            IRET
        UPPERCASE_END:
            NOP


CODE ENDS
END START