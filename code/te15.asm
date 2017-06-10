ASSUME CS:CODE

STACK SEGMENT
    DB 128 DUP(0)
STACK ENDS 

CODE SEGMENT
    START:
        ; 设置栈段
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 128

        ; 设置中断要安装的目的地的段地址
        MOV AX, 0
        MOV ES, AX

        ; 将INT 9中断例程的段地址和偏移地址保存在 0:200H-0:204H中
        PUSH ES:[9*4]
        PUSH ES:[9*4+2]
        POP ES:[202H]
        POP ES:[200H]

        ; 获取要安装的程序的地址
        MOV AX, CS
        MOV DS, AX
        MOV SI, OFFSET INT9

        ; 将中断例程安装到0:204H位置
        MOV DI, 204H
        MOV CX, OFFSET INT9_END - OFFSET INT9
        CLD
        REP MOVSB

        ; 设置INT 9 中断向量表
        MOV WORD PTR ES:[9*4], 204H
        MOV WORD PTR ES:[9*4+2], 0

        MOV AX, 4C00H
        INT 21H

    INT9:
        PUSH AX
        PUSH ES
        PUSH DI
        PUSH CX

        ; 先调用原来的INT 9中断例程
        PUSHF
        CALL DWORD PTR CS:[200H]

        ; 获取键盘扫描码
        ; 并判断是否是松开'A'时的断码
        IN AL, 60H
        CMP AL, 9EH
        JNE INT9RET

        ; 显示全屏的'A'
        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 0
        MOV CX, 2000
        AA:
            MOV BYTE PTR ES:[DI], 'A'
            ADD DI, 2
        LOOP AA

        INT9RET:
            POP CX
            POP DI
            POP ES
            POP AX
            IRET
    INT9_END:
        NOP
CODE ENDS
END START