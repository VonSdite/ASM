ASSUME CS:CODE

CODE SEGMENT
    A DW 1, 2, 3, 4, 5, 6, 7, 8
    B DD 0
    C DW OFFSET A, OFFSET B
    START:
        MOV AX, SEG START
        MOV SI, 0
        MOV CX, 0
        S:
            MOV AX, A[SI]
            ADD WORD PTR B[0], AX
            ADC WORD PTR B[2], 0
            ADD SI, 2
        LOOP S

        MOV AX, 4C00H
        INT 21H
CODE ENDS
END START