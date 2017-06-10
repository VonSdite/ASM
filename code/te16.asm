assume cs:code

code segment
    start:
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
            ; 注装载进去，table标号标记着这个位置的偏移地址
            ; (是装载程序的，装载进去是不会变的)，
            ; 所以下面call word ptr 不能用table[bx]， 同理sub1 等等
            table dw sub1-int7ch+200h, sub2-int7ch+200h, sub3-int7ch+200h, sub4-int7ch+200h

            set:
                push bx

                cmp ah, 3
                ja sret
                mov bl, ah
                mov bh, 0
                add bx, bx
                call word ptr cs:[bx+202h]
            sret:
                pop bx
                iret 

        ; 清屏子程序
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

            ; 颜色属性越界直接返回
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
            push es
            push cx

            ; 颜色属性越界直接返回
            cmp al, 7
            ja sub3ret

            mov bx, 0b800h
            mov es, bx
            mov bx, 1
            mov cl, 4
            shl al, cl
            mov cx, 2000
            sub3s:
                and byte ptr es:[bx], 10001111b
                or es:[bx], al
                add bx, 2
            loop sub3s 

            sub3ret:
                pop cx
                pop es
                pop bx
                ret

        sub4:
            push si
            push di
            push ds
            push es
            push cx

            mov si, 0b800h
            mov ds, si
            mov es, si
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
            pop es
            pop ds
            pop di
            pop si
            ret
    int7ch_end:
        nop
    
code ends
end start