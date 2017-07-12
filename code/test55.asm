assume cs:code

stack segment
    db 128 dup(0)
stack ends

data segment
    db "welcome to masm!", 0
data ends

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

        mov dh, 10
        mov dl, 10
        mov cl, 2
        mov ax, data 
        mov ds, ax
        mov si, 0
        int 7ch


        mov ax, 4c00h
        int 21h
int7ch:
    push ax
    push bx
    push cx
    push dx
    push es
    push si

    mov bx, 0b800h
    mov es, bx
    mov al, 160
    mul dh
    mov bx, ax
    mov al, 2
    mul dl
    add bx, ax
    mov ch, cl
    int7ch_show:
        cmp byte ptr ds:[si], 0
        je int7ch_ret
        mov cl, ds:[si]
        mov es:[bx], cx
        inc si
        add bx, 2
        jmp short int7ch_show
    int7ch_ret:
        pop si
        pop es
        pop dx
        pop cx
        pop bx
        pop ax
        iret
int7ch_end:
    nop
code ends
end start