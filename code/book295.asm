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
        TABLE DW AG0, AG30, AG60, AG90, AG120, AG150, AG180  ; 字符串偏移地址表
        AG0   DB '0', 0                ; sin(0)对应的字符串"0"
        AG30  DB '0.5', 0              ; sin(30)对应的字符串"0.5"                
        AG60  DB '0.866', 0            ; sin(60)对应的字符串"0.866"    
        AG90  DB '1', 0                ; sin(90)对应的字符串"1"
        AG120 DB '0.866', 0            ; sin(120)对应的字符串"0.866"    
        AG150 DB '0.5', 0              ; sin(150)对应的字符串"0.5"    
        AG180 DB '0', 0                ; sin(180)对应的字符串"0"

        SHOW:
            PUSH DX
            PUSH BX
            PUSH ES
            PUSH DI
            PUSH AX

            ; 角度/30作为相对于TABLE的偏移
            ; 取得偏移地址，存放在BX中
            MOV DX, 0
            MOV BX, 30
            DIV BX
            MOV BX, AX
            ADD BX, BX
            MOV BX, TABLE[BX]

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
        SHOWRET:
            POP AX
            POP DI
            POP ES
            POP BX
            POP DX
            RET 

CODE ENDS
END START

