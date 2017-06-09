ASSUME CS:CODE 

STACK SEGMENT
    DW 16 DUP(0)
STACK ENDS

CODE SEGMENT
    START:
        MOV AX, STACK
        MOV SS, AX
        MOV SP, 20H

        MOV SI, 10H
        MOV CX, 7
        MOV DH, 10
        MOV BH, 0
        MOV BL, 2
        S0:
            PUSH CX
            MOV CX, 16
            MOV DL, 0 
            S1:
                PUSH CX
                MOV AH, 2
                INT 10H
                MOV AX, SI
                MOV AH, 9
                MOV CX, 1
                INT 10H
                INC DL

                MOV AH, 2
                INT 10H
                MOV AH, 9
                MOV AL, ' ' 
                MOV CX, 1
                INT 10H
                INC DL

                INC SI
                POP CX
            LOOP S1
            INC DH
            POP CX
        LOOP S0

        MOV AX, 4C00H
        INT 21H

CODE ENDS
END START