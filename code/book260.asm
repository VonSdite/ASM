ASSUME CS:CODE

CODE SEGMENT
    START:
        MOV AH, 2
        MOV BH, 0
        MOV DH, 5
        MOV DL, 12
        INT 10H

        MOV AH, 9
        MOV AL, 'a'
        MOV BL, 11001010B
        MOV BH, 0
        MOV CX, 3
        INT 10H

        MOV AX, 4C00H
        INT 21H
CODE ENDS
END START