assume cs:code, ds:data

data segment
    db 'Welcome to masm!', 0
data ends

code segment
    start:
        mov dh, 8
        mov dl, 3
        mov cl, 2
        mov ax, data
        mov ds, ax
        mov si, 0
        call show_str

        mov ax, 4c00h
        int 21h

show_str:
    push bx
    push es
    push ax
    push si
    push cx

    mov bx, 0b800h
    mov es, bx
    mov al, 160
    mul dh
    mov bx, ax
    mov al, 2
    mul dl
    add bx, ax

    mov ch, cl
    show:
        cmp byte ptr ds:[si], 0
        je ok
        mov cl, ds:[si]
        mov es:[bx], cx
        add bx, 2
        inc si
        jmp short show

    ok:
        pop cx
        pop si
        pop ax
        pop es
        pop bx
        ret

code ends

end start