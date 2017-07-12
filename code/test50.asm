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

        mov ax, 3456
        int 7ch
        add ax, ax
        adc dx, dx

        mov ax, 4c00h
        int 21h
        
        
        
        

        mov ax, 4c00h
        int 21h
        

int7ch:
    mul ax
    iret
int7ch_end:
    nop

code ends
end start