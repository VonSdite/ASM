ASSUME CS:CODE

CODE SEGMENT
    START:
        MOV AX, 0B800H
        MOV ES, AX
        MOV DI, 160*12

        MOV BX, OFFSET S - OFFSET SE
        MOV CX, 80
        S:
            MOV BYTE PTR ES:[DI], '!'
            ADD DI, 2
        INT 7CH
        SE:
            NOP

        MOV AX, 4C00H
        INT 21H

CODE ENDS
END START