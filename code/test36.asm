assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ax, cs
        mov ds, ax
        mov si, offset int7ch
        mov ax, 0
        mov es, ax
        mov di, 200h 

        mov cx, offset int7ch_end - offset int7ch
        cld
        rep movsb

        mov word ptr es:[7ch*4], 200h
        mov word ptr es:[7ch*4+2], 0h

        mov ax, 4c00h
        int 21h

    int7ch:
        setscreen:
            jmp short set
            table dw sub1-int7ch+200h, sub2-int7ch+200h, sub3-int7ch+200h, sub4-int7ch+200h

            set:
                push bx
                cmp ah, 3
                ja sret

                mov bh, 0
                mov bl, ah
                add bx, bx
                call word ptr cs:[bx+202h]
            sret:
                pop bx
                iret
        sub1:
            push bx
            push es
            push cx

            mov bx, 0b800h
            mov es, bx
            mov bx, 0
            mov cx, 2000
            sub1s:
                mov byte ptr es:[bx], ' '
                add bx, 2
            loop sub1s

            pop cx
            pop es
            pop bx
            ret

        sub2:
            push bx
            push es
            push cx

            cmp al, 7
            ja sub2ret

            mov bx, 0b800h
            mov es, bx
            mov bx, 1
            mov cx, 2000
            sub2s:
                and byte ptr es:[bx], 11111000b
                or es:[bx], al
                add bx, 2
            loop sub2s
            
        sub2ret:
            pop cx
            pop es
            pop bx
            ret

        sub3:
            push bx
            push cx
            push es

            cmp al, 7
            ja sub3ret

            mov cl, 4
            shl al, cl
            mov bx, 0b800h
            mov es, bx
            mov bx, 1
            mov cx, 2000
            sub3s:
                and byte ptr es:[bx], 10001111B
                or es:[bx], al
                add bx, 2
            loop sub3s
        sub3ret:
            pop es
            pop cx
            pop bx
            ret

        sub4:
            push si
            push di
            push es
            push ds
            push cx

            mov si, 0b800h
            mov es, si
            mov ds, si
            mov si, 160
            mov di, 0
            mov cx, 24
            cld
            sub4s:
                push cx
                mov cx, 160
                rep movsb
                pop cx
            loop sub4s

            mov cx, 80
            sub4ss:
                mov byte ptr es:[di], ' '
                add di, 2
            loop sub4ss

            pop cx
            pop ds
            pop es
            pop di
            pop si
            ret
    int7ch_end:
        nop
        
code ends
end start