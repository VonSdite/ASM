assume cs:code 

data segment
    db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

code segment
    start:
        mov ax, data
        mov ds, ax
        mov si, 0
        call letterc
        mov dh, 8
        mov dl, 3
        mov cl, 2
        call show_str

        mov ax, 4c00h
        int 21h

; ds:si指向字符串首地址
letterc:
    push si
    lettercc:
        cmp byte ptr ds:[si], 0
        je lettercret
        cmp byte ptr ds:[si], 'a'
        jb letternext
        cmp byte ptr ds:[si], 'z'
        ja letternext
        and byte ptr ds:[si], 11011111B
    letternext:
        inc si
        jmp short lettercc
    lettercret:
        pop si
        ret

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