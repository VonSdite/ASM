ASSUME CS:CODE

CODE SEGMENT
    A DB 1, 2, 3, 4, 5, 6, 7, 8
    B DW 0
    START:
        MOV SI, 0
        MOV AH, 0
        MOV CX, 8
        S:
            MOV AL, A[SI]
            ADD B, AX
            INC SI
        LOOP S

        MOV AX, 4C00H
        INT 21H
         
CODE ENDS
END START