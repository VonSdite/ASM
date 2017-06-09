assume cs:code, DS:DATA, SS:STACK

DATA SEGMENT
    DW 6 DUP(0)
DATA ENDS

STACK SEGMENT
    DW 16 DUP(0)
STACK ENDS

code segment
    start:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 20H

        MOV AX, 3456
        INT 7CH

        ADD AX, AX
        ADC DX, DX

        MOV BX, DATA
        MOV DS, BX
        CALL DTOC
        CALL SHOW

        mov ax, 4c00H
        int 21H

    DTOC:
        PUSH BX
        PUSH DX
        PUSH SI
        PUSH CX
        PUSH AX

        MOV BX, 10
        CHANGE:
            MOV DX, 0
            DIV BX
            CMP AX, 0
            JE OK
            ADD DX, 30H
            PUSH DX
            INC SI
            JMP SHORT CHANGE
        OK:
            ADD DX, 30H
            PUSH DX
            INC SI
            MOV CX, SI
            MOV SI, 0
            S:
                POP DS:[SI]
                ADD SI, 2
            LOOP S
            MOV BYTE PTR DS:[SI], 0

            POP AX
            POP CX
            POP SI
            POP DX
            POP BX
            RET

    SHOW:
        PUSH AX
        PUSH ES
        PUSH DS
        PUSH SI

        MOV AX, 0B800H
        MOV ES, AX
        MOV AX, DATA
        MOV DS, AX
        MOV SI, 0
    SEE:
        CMP WORD PTR DS:[SI], 0
        JE OK1
        PUSH DS:[SI]
        POP ES:[SI]
        MOV BYTE PTR ES:[SI+1], 2
        ADD SI, 2
        JMP SHORT SEE
    OK1:
        POP SI
        POP DS
        POP ES
        POP AX
        RET
code ends
end start