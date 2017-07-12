assume cs:code

code segment
    start:
        mov ax, cs
        mov ds, ax
        mov si, offset int0
        mov ax, 0
        mov es, ax
        mov di, 200h

        mov cx, offset int0_end - offset int0
        cld
        rep movsb

        mov word ptr es:[0*4], 200h
        mov word ptr es:[0*4+2], 0h

        mov ax, 4c00h
        int 21h

    int0:
        jmp short int0_show
        db "Overflow!", 0
        int0_show:
            push bx
            push es
            push si
            push ax

            mov bx, 0b800h
            mov es, bx
            mov bx, 12*160+39*2
            mov si, 202h
            mov ah, 2
            int0_s:
                cmp byte ptr cs:[si], 0 
                je int0_ret
                mov al, cs:[si]
                mov es:[bx], ax
                add bx, 2
                inc si
                jmp short int0_s
        int0_ret:
            pop ax
            pop si
            pop es
            pop bx
            iret
    int0_end:
        nop


code ends

end start