assume cs:code, ds:data

stack segment
    db 128 dup(0)
stack ends

data segment
    db 6 dup(0)
data ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        
        mov ax, data
        mov ds, ax
        mov si, 0
        mov ax, 65535
        mov dx, 5
        call dtoc
        mov cl, 2
        mov dh, 8
        mov dl, 3
        call show_str
        

        mov ax, 4c00h
        int 21h

dtoc:
    push ax
    push cx
    push dx
    push si
    push di
    
    mov di, 0
    change:
        mov cx, 10
        call divdw
        add cx, 30h
        push cx
        inc di
        cmp ax, 0
        je dtocok1
        jmp short change
        dtocok1:
            cmp dx, 0
            je dtocok
        jmp short change

    dtocok:
        mov cx, di
        dtocs:
            pop dx
            mov ds:[si], dl
            inc si
        loop dtocs
        mov byte ptr ds:[si], 0 

        pop di
        pop si
        pop dx
        pop cx
        pop ax
        ret

divdw:
    push bx
    push ax
    mov ax, dx
    sub dx, dx
    div cx
    mov bx, ax
    pop ax
    div cx
    mov cx, dx
    mov dx, bx
    pop bx
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
        je showok
        mov cl, ds:[si]
        mov es:[bx], cx
        add bx, 2
        inc si
        jmp short show

    showok:
        pop cx
        pop si
        pop ax
        pop es
        pop bx
        ret

code ends

end start