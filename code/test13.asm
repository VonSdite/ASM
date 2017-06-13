assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov bh, 0
        mov bl, 2
        mov dh, 10
        mov si, 10h

        mov cx, 7
        s0:
            push cx
            mov cx, 16
            mov dl, 23
            s1:
                push cx
                mov ah, 2
                int 10h
                mov ax, si
                mov ah, 9
                mov cx, 1
                int 10h
                inc dl

                mov ah, 2
                int 10h
                mov ax, ' '
                mov ah, 9
                mov cx, 1
                int 10h

                inc dl
                inc si
                pop cx
            loop s1
            inc dh
            pop cx
        loop s0

        mov ax, 4c00h
        int 21h
        
code ends
end start