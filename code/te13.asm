ASSUME CS:CODE

CODE SEGMENT
    START:
        ; 设置源地址
        MOV AX, CS
        MOV DS, AX
        MOV SI, OFFSET SHOW

        ; 设置复制到的目的地址
        MOV AX, 0
        MOV ES, AX
        MOV DI, 200H
        
        ; 安装中断例程
        MOV CX, OFFSET SHOW_END - OFFSET SHOW
        CLD
        REP MOVSB

        ; 设置到中断向量表
        MOV WORD PTR ES:[7CH*4], 200H
        MOV WORD PTR ES:[7CH*4+2], 0H

        MOV AX, 4C00H
        INT 21H

    SHOW:
        PUSH AX
        PUSH ES
        PUSH DI
        PUSH BX
        PUSH SI

        MOV AX, 0B800H
        MOV ES, AX

        MOV AL, 160
        MUL DH
        MOV BX, AX

        MOV AL, 2
        MUL DL
        MOV DI, AX

        SHOW_STR:
            CMP BYTE PTR DS:[SI], 0
            JE OK
            MOV AL, DS:[SI]
            MOV ES:[BX+DI], AL
            MOV ES:[BX+DI+1], CL
            INC SI
            ADD DI, 2
            JMP SHORT SHOW_STR
        OK:
            POP SI
            POP BX
            POP DI
            POP ES
            POP AX
            IRET
    SHOW_END:
        NOP

CODE ENDS
END START