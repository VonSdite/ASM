ASSUME CS:CODE

STACK SEGMENT
    DB 128 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 128

        MOV AX, 0
        MOV ES, AX
        PUSH ES:[9*4]
        PUSH ES:[9*4+2]
        POP ES:[202H]
        POP ES:[200H] 

        MOV AX, CS
        MOV DS, AX
        MOV SI, OFFSET INT9

        MOV DI, 204H
        MOV CX, OFFSET INT9_END - OFFSET INT9
        CLD
        REP MOVSB

        CLI
        MOV WORD PTR ES:[9*4], 204H
        MOV WORD PTR ES:[9*4+2], 0H
        STI

        MOV AX, 4C00H
        INT 21H

    INT9:
        PUSH AX
        PUSH ES
        PUSH CX
        PUSH DI

        PUSHF
        CALL DWORD PTR CS:[200H]

        IN AL, 60H
        CMP AL, 3BH
        JNE INT9RET

        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 1
        MOV AL, 10H
        MOV CX, 2000
        CC:
            ADD BYTE PTR ES:[DI], AL
            ; INC BYTE PTR ES:[DI]
            ADD DI, 2
        LOOP CC

    INT9RET:
        POP DI
        POP CX
        POP ES
        POP AX
        IRET
    INT9_END:
        NOP
        

CODE ENDS
END START