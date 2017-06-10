assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ah, 0
        int 7ch

        call delay

        mov ah, 1
        mov al, 2
        int 7ch

        call delay

        mov ah, 2
        mov al, 1
        int 7ch

        call delay

        mov ah,3 
        int 7ch

        mov ax, 4c00h
        int 21h
    
    delay:
        push dx
        push ax
        mov dx, 10h
        mov ax, 0h
        delays:
            sub ax, 1
            sbb dx, 0
            cmp ax, 0
            jne delays
            cmp dx, 0
            jne delays
        pop ax
        pop dx
        ret
code ends
end start