assume cs:code 

code segment
    start:
        mov al, 100
        mov ah, 0
        div ah

        mov ax, 4c00h
        int 21h
code ends

end start