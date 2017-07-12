assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ah, 2
        mov bh, 0
        mov dh, 5
        mov dl, 6
        int 10h
        
        
        
        

        mov ax, 4c00h
        int 21h
        
code ends
end start