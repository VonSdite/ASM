ASSUME CS:CODE

STACK SEGMENT
    DB 128 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 128

        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 12*160+39*2

        MOV AL, 'a'
        S:
            MOV BYTE PTR ES:[DI], AL
            MOV BYTE PTR ES:[DI+1], 2
            CALL DALAY
            INC AL
            CMP AL, 'z'
        JNA S

        MOV AX, 4C00H
        INT 21H

    DALAY:
        PUSH DX
        PUSH AX

        ; 由于DOSBOX运行速度比较慢，所以设置循环次数比较小
        MOV DX, 0010H
        MOV AX, 0000H
        D:  
            SUB AX, 1
            SBB DX, 0
            CMP AX, 0
            JNE D
            CMP DX, 0
            JNE D
        POP AX
        POP DX
        RET

CODE ENDS
END START 