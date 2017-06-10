ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    DB 9, 8, 7, 4, 2, 0
    ; 分别是 年月日时分秒的位置
    C DB '/', '/', ' ', ':', ':' 
DATA ENDS

STACK SEGMENT
    DW 8 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        ; 设置栈段
        MOV AX, STACK
        MOV SS, AX  
        MOV SP, 10H

        ; 设置数据段，内容为CMOS RAM存放时间的位置
        MOV AX, DATA
        MOV DS, AX
        MOV DI, 0

        ; 设置显示位置
        MOV AX, 0B800H
        MOV ES, AX
        MOV SI, 0

        ; 六个时间
        MOV CX, 6
        S:
            PUSH CX

            ; 从CMOS RAM获取时间
            MOV AL, DS:[DI]
            OUT 70H, AL
            IN AL, 71H

            ; 将数值码转换为四位二进制BCD码
            MOV AH, AL
            MOV CL, 4
            SHR AH, CL
            AND AL, 00001111B

            ; 将数值转换为字符
            ADD AL, 30H
            ADD AH, 30H
            MOV ES:[SI], AH
            MOV BYTE PTR ES:[SI+1], 2
            MOV ES:[SI+2], AL
            MOV BYTE PTR ES:[SI+3], 2

            ; 输出'/', ' ', ':' 三个中的一个
            MOV AL, C[DI]
            MOV BYTE PTR ES:[SI+4], AL
            MOV BYTE PTR ES:[SI+5], 2
            OK:
                ADD SI, 6
                INC DI
                POP CX
        LOOP S

        MOV AX, 4C00H
        INT 21H
CODE ENDS
END START