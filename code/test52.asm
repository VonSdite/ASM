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
        mov word ptr es:[7ch*4+2], 0

        mov ax, 0b800h
        mov es, ax
        mov di, 160*12
        mov bx, offset s - offset se
        mov cx, 80
        s:
            mov byte ptr es:[di], '!'
            add di, 2
            int 7ch
        se:nop

        mov ax, 4c00h
        int 21h

int7ch:
    push bp
    dec cx
    jcxz int7ch_ret
    mov bp, sp
    add ss:[bp+2], bx 
    int7ch_ret:
        pop bp
        iret
int7ch_end:
    nop
code ends
end start