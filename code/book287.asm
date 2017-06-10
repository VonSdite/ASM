ASSUME CS:CODE

CODE SEGMENT
    A: DB 1, 2, 3, 4, 5, 6, 7, 8
    B: DW 0

    START:
        MOV SI, OFFSET A
        MOV DI, OFFSET B
        MOV AH, 0
        S:
            MOV AL, CS:[SI]
            ADD CS:[DI], AX
            INC SI
            CMP SI, DI
            JNE S

        MOV AX, 4C00H
        INT 21H

CODE ENDS
END START