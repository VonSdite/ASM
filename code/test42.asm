assume cs:code, ds:data

data segment
    string db 'welcome to masm!'
    color db 00000010B, 00101000B, 01110001B
data ends

code segment
    start:
        mov ax, data
        mov ds, ax

        mov ax, 0b800h
        mov es, ax
        mov di, 11*160+31*2

        mov cx, 3
        mov si, 0
        s0:
            push cx
            push di
            mov ah, color[si] 
            mov bx, 0
            mov cx, 16
            s1:
                mov al, string[bx]
                mov es:[di], ax
                add di, 2
                inc bx
            loop s1

            pop di
            add di, 160
            inc si
            pop cx
        loop s0

        mov ax, 4c00h
        int 21h

code ends
end start