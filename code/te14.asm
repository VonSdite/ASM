assume cs:code, ds:data, ss:stack

data segment
    db 9, 8, 7, 4, 2, 0
data ends

stack segment
    dw 8 dup(0)
stack ends

code segment
    start:
        mov ax, data
        mov ds, ax

        mov ax, stack
        mov ss, ax
        mov sp, 10H

        mov bx, 0b800h
        mov es, bx
        mov si, 0
        mov di, 0
        mov cx, 6
        s0:
            push cx
            mov al, ds:[di]
            out 70h, al
            in al, 71h

            mov ah, al
            mov cl, 4
            shr ah, cl
            and al, 00001111B

            add ah, 30H
            add al, 30H

            mov byte ptr es:[si], ah
            mov byte ptr es:[si+1], 2
            add si, 2
            mov byte ptr es:[si], al
            mov byte ptr es:[si+1], 2
            add si, 2
            cmp di, 0
            je c1
            cmp di, 1
            je c1
            cmp di, 2
            je c2
            cmp di, 3
            je c3
            cmp di, 4
            je c3
            jmp en
            c1:
                mov byte ptr es:[si], '/'
                mov byte ptr es:[si+1], 2
                jmp en
            c2:
                mov byte ptr es:[si], ' '
                mov byte ptr es:[si+1], 2
                jmp en
            c3:
                mov byte ptr es:[si], ':'
                mov byte ptr es:[si+1], 2
                jmp en
            en:    
                add si, 2
                inc di
                pop cx
        loop s0

        mov ax, 4c00H
        int 21H

code ends
end start