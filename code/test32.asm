ASSUME CS:CODE 

STACK SEGMENT
    DW 16 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 20H
        
        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 0

        MOV BL, 0
        MOV CX, 13
        S:
            PUSH CX
            MOV AL, BL
            OUT 70H, AL
            IN AL, 71H

            MOV AH, AL
            MOV CL, 4
            SHR AH, CL
            AND AL, 00001111B

            ADD AH, 30H
            ADD AL, 30H

            MOV ES:[DI], AH
            MOV BYTE PTR ES:[DI+1], 2

            MOV ES:[DI+2], AL
            MOV BYTE PTR ES:[DI+3], 2

            MOV BYTE PTR ES:[DI+4], ' '
            MOV BYTE PTR ES:[DI+5], 2

            ADD DI, 6
            INC BL
            POP CX
        LOOP S

        MOV AX, 4C00H
        INT 21H

CODE ENDS
END START