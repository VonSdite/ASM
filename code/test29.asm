ASSUME CS:CODE

DATA SEGMENT
    DB 9, 8, 7, 4, 2, 0
DATA ENDS

CODE SEGMENT
    START:
        MOV AX, DATA
        MOV DS, AX
        MOV DI, 0

        MOV AX, 0B800H
        MOV ES, AX
        MOV SI, 0

        MOV CX, 10
        S:
            PUSH CX
            MOV AL, DS:[DI]
            OUT 70H, AL
            IN AL, 71H

            MOV AH, AL
            MOV CL, 4
            SHL AH, CL
            AND AL, 00001111B

            ADD AL, 30H
            ADD AH, 30H
            MOV ES:[SI], AH
            MOV BYTE PTR ES:[SI+1], 2
            MOV ES:[SI+2], AL
            MOV BYTE PTR ES:[SI+3], 2

            ADD SI, 4
            INC DI
            POP CX
        LOOP S

        MOV AX, 4C00H
        INT 21H
CODE ENDS
END START