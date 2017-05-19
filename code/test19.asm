assume cs:code 

code segment
    mov ax, 1000H
    mov bh, 1
    div bh

    mov ax, 4c00H
    int 21H
code ends
end