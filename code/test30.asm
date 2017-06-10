ASSUME CS:CODE

CODE SEGMENT
    START:
        MOV AX, CS
        MOV DS, AX
        MOV SI, OFFSET JN

        MOV AX, 0
        MOV ES, AX
        MOV DI, 200H

        MOV CX, OFFSET JN_END - OFFSET JN
        CLD
        REP MOVSB

        MOV WORD PTR ES:[7CH*4], 200H
        MOV WORD PTR ES:[7CH*4+2], 0H

        MOV AX, 4C00H
        INT 21H

    JN:
        PUSH BP
        MOV BP, SP
        ADD SS:[BP+2], BX
        POP BP
        IRET
    JN_END:
        NOP
CODE ENDS

END START