ASSUME CS:CODE

STACK SEGMENT
    DB 128 DUP(0)
STACK ENDS

DATA SEGMENT 
    DW 0, 0
DATA ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 128

        MOV AX, DATA
        MOV DS, AX

        MOV AX, 0
        MOV ES, AX
        PUSH ES:[9*4+2]
        PUSH ES:[9*4]

        POP DS:[0]      ; 保留的IP
        POP DS:[2]      ; 保留的CS

        CLI
        MOV WORD PTR ES:[9*4], OFFSET INT9
        MOV WORD PTR ES:[9*4+2], CS
        STI

        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 12*160+39*2

        MOV AL, 'a'
        S:
            MOV BYTE PTR ES:[DI], AL
            CALL DELAY
            INC AL
            CMP AL, 'z'
            JNA S

        MOV AX, 0
        MOV ES, AX
        PUSH DS:[0]
        PUSH DS:[2]
        POP ES:[9*4+2]
        POP ES:[9*4]

        MOV AX, 4C00H
        INT 21H

    DELAY:
        PUSH DX
        PUSH AX

        MOV DX, 0010H
        MOV AX, 0000H
        NZ:
            SUB AX, 1
            SBB DX, 0
            CMP AX, 0
            JNE NZ
            CMP DX, 0
            JNE NZ
        Z:
            POP AX
            POP DX
            RET

    INT9:
        PUSH AX
        PUSH BX
        PUSH ES

        PUSHF
        ; PUSHF
        ; POP BX
        ; ADD BH, 11111100B
        ; PUSH BX
        ; POPF

        CALL DWORD PTR DS:[0]

        IN AL, 60H
        CMP AL, 1
        JNE INT9RET

        MOV AX, 0B800H
        MOV ES, AX
        INC BYTE PTR ES:[12*160+39*2+1]

        INT9RET:
            POP ES
            POP BX
            POP AX
            IRET
    
CODE ENDS
END START