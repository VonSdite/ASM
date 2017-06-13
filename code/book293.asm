assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        
        mov al, 0FAH
        call showbyte
        
        

        mov ax, 4c00h
        int 21h
        
    ; 用al来传递数据
    showbyte:
        jmp short show
        table db '0123456789ABCDEF'

    show:
        push ax
        push bx
        push es
        push cx

        mov ah, al
        mov cl, 4
        shr ah, cl
        and al, 00001111B
        mov bh, 0
        mov bl, al
        mov al, table[bx]
        mov bl, ah
        mov ah, table[bx]

        mov bx, 0b800h
        mov es, bx
        mov bx, 12*160+39*2

        mov es:[bx], ah
        mov byte ptr es:[bx+1], 2
        mov es:[bx+2], al
        mov byte ptr es:[bx+3], 2

        pop cx
        pop es
        pop bx
        pop ax
    showret:
        ret
code ends
end start