ASSUME CS:CODE

CODE SEGMENT
    START:
        ; 被复制的代码位置
        MOV AX, CS
        MOV DS, AX
        MOV SI, OFFSET SQURE

        ; 设置代码复制到的目的位置
        MOV AX, 0
        MOV ES, AX
        MOV DI, 200H

        ; 计算复制的代码长度
        MOV CX, OFFSET SQURE_END - OFFSET SQURE
        CLD
        REP MOVSB  ; 复制代码

        ; 设置到中断向量表中
        MOV WORD PTR ES:[7CH*4], 200H
        MOV WORD PTR ES:[7CH*4+2], 0H

        MOV AX, 4C00H
        INT 21H

    SQURE:
        MUL AX
        IRET 
    SQURE_END:
        NOP

CODE ENDS
END START