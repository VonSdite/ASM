assume cs:code, ss:stack

stack segment
    dw 8 dup (0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 10H             ; 设置栈段

        mov ax, 0B852H              
        mov es, ax              ; 设置显示位置为居中
        mov bx, 0EH             

        mov ah, 7               ; 颜色属性:白色
        mov al, 10H             ; 起始字符
        mov cx, 7               ; 七行
        s0:
            push cx
            push bx
            mov cx, 16          ; 16列
            s1:
                mov es:[bx], ax
                inc al
                add bx, 2
                mov word ptr es:[bx], 20H
                add bx, 2
            loop s1
            pop bx
            add bx, 0a0H        ; 跳到下一行
            pop cx
        loop s0

        mov ax, 4c00H
        int 21H
code ends
end start