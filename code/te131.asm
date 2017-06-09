ASSUME CS:CODE

CODE SEGMENT
    START:
        ; 设置源地址
        MOV AX, CS
        MOV DS, AX
        MOV SI, OFFSET LP

        ; 设置复制到的目的地址
        MOV AX, 0
        MOV ES, AX
        MOV DI, 200H

        ; 安装中断例程
        MOV CX, OFFSET LP_END - OFFSET LP
        CLD
        REP MOVSB

        ; 设置到中断向量表
        MOV WORD PTR ES:[7CH*4], 200H
        MOV WORD PTR ES:[7CH*4+2], 0H

        MOV AX, 4C00H
        INT 21H

    LP:
        PUSH BP
        DEC CX
        JCXZ OK
        MOV BP, SP
        ADD SS:[BP+2], BX
        OK:
            POP BP
            IRET
    LP_END:
        NOP
CODE ENDS
END START