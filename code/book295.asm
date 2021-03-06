ASSUME CS:CODE

STACK SEGMENT
    DB 128 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 128

        MOV AX, 30
        CALL SHOWSIN

        MOV AX, 4C00H
        INT 21H

    ; 用AX向SHOWSIN传递角度
    SHOWSIN:
        JMP SHORT SHOW
        TABLE DW AG0, AG30, 0, AG90, 0, AG150, AG180  ; 字符串偏移地址表
        AG0   DB '0', 0                ; sin(0)对应的字符串"0"
        AG30  DB '0.5', 0              ; sin(30)对应的字符串"0.5"                
        AG90  DB '1', 0                ; sin(90)对应的字符串"1"
        AG150 DB '0.5', 0              ; sin(150)对应的字符串"0.5"    
        AG180 DB '0', 0                ; sin(180)对应的字符串"0"

        SHOW:
            PUSH DX
            PUSH BX
            PUSH ES
            PUSH DI
            PUSH AX

            CMP AX, 180
            JA ERROR
            ; 角度/30作为相对于TABLE的偏移
            ; 取得偏移地址，存放在BX中
            ; 由于除以30，其中60，与120不在范围内，设置偏移地址为0，用于判断
            MOV DX, 0
            MOV BX, 30
            DIV BX
            CMP DX, 0       ; 用于检查角度值是否在范围内
            JNE ERROR
            MOV BX, AX
            ADD BX, BX
            MOV BX, TABLE[BX]

            CMP BX, 0
            JE ERROR

            ; 显示SIN(X)对应的字符串
            MOV AX, 0B800H
            MOV ES, AX
            MOV DI, 12*160+38*2
        SHOWS:
            CMP BYTE PTR CS:[BX], 0
            JE SHOWRET
            MOV AH, CS:[BX]
            MOV ES:[DI], AH
            MOV BYTE PTR ES:[DI+1], 2

            ADD DI, 2
            INC BX
            JMP SHORT SHOWS

        ERROR:
            JMP SHORT ERROR_SHOW
            EE DB 'Error Angle!', 0

            ERROR_SHOW:
                ; 显示错误角度
                MOV AX, 0B800H
                MOV ES, AX
                MOV DI, 12*160+34*2
                MOV BX, 0
                ESS:
                    CMP BYTE PTR EE[BX], 0
                    JE SHOWRET
                    MOV AL, EE[BX]
                    MOV ES:[DI], AL
                    MOV BYTE PTR ES:[DI+1], 2
                    ADD DI, 2
                    INC BX
                    JMP SHORT ESS
        SHOWRET:
            POP AX
            POP DI
            POP ES
            POP BX
            POP DX
            RET 

CODE ENDS
END START

