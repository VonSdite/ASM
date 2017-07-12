assume cs:code

code segment
    mov ax, 100
    start:
        mov ax, 10
    
    mov ax, 4c00h
    int 21h

code ends
end START