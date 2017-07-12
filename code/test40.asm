assume cs:code, ds:data, ss:stack

stack segment
    dw 8 dup(0)
stack ends

data segment 
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
data ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 16

        mov ax, data
        mov ds, ax

        mov bx, 0
        mov cx, 4
        s:
            push cx
            mov cx, 4
            mov si, 0
            s1:
                and byte ptr ds:[bx].3[si], 11011111B
                inc si
            loop s1

            add bx, 16
            pop cx
        loop s

        mov ax, 4c00h
        int 21h
code ends

end start
