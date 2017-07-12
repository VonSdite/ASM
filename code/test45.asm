assume cs:code

;******************
;  数据段、栈段     *
;******************
data segment
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983', '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992', '1993', '1994', '1995'
    ;以上是表示21年的21个字符串

    dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
    ;以上是表示21年公司总收入的21个dword型数据

    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800
    ;以上是表示21年公司雇员人数的21个word型数据
data ends

stack segment
    dw 128 dup (0)
stack ends

; 用于临时存储要显示的十进制数的字符串
da segment
    dw 4 dup(0)
da ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ax, data
        mov ds, ax

        mov ax, da
        mov es, ax

        mov bx, 0
        
        mov si, 0
        mov di, 0
        mov cx, 21
        mov dh, 3
        s:
            push cx
            mov cx, 4
            rep movsb
            mov byte ptr es:[di], 0

            mov dl, 4
            mov cl, 2
            mov di, 0
            call show_str
            
            push dx
            mov ax, ds:[si].80
            mov dx, ds:[si].82
            call dtoc 
            pop dx
            add dl, 8
            call show_str

            push dx
            mov dx, 0
            mov ax, ds:[bx].168
            call dtoc
            pop dx
            add dl, 11
            call show_str

            push dx
            push cx
            mov ax, ds:[si].80
            mov dx, ds:[si].82
            mov cx, ds:[bx].168
            call divdw
            call dtoc
            pop cx
            pop dx
            add dl, 10
            call show_str

            add bx, 2
            inc dh
            pop cx
        loop s

        mov ax, 4c00h
        int 21h


; ax低位数据，dx存放高位数据， es:di指向字符串的首地址
dtoc:
    push ax
    push cx
    push dx
    push si
    push di
    
    mov si, 0
    change:
        mov cx, 10
        call divdw
        add cx, 30h
        push cx
        inc si
        cmp ax, 0
        je dtocok1
        jmp short change
        dtocok1:
            cmp dx, 0
            je dtocok
        jmp short change

    dtocok:
        mov cx, si
        dtocs:
            pop dx
            mov es:[di], dl
            inc di
        loop dtocs
        mov byte ptr es:[di], 0 

        pop di
        pop si
        pop dx
        pop cx
        pop ax
        ret

; 参数：ax低16位，dx高十六位，除数cx
; 返回值：ax结果低16位，dx结果高16位，cx余数
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


; 参数： dh行号， dl列号，cl颜色，es：di指向输出的字符，以0位结束符 
show_str:
    push ax
    push bx
    push cx
    push di
    push ds

    mov bx, 0b800h
    mov ds, bx
    mov al, 160
    mul dh
    mov bx, ax
    mov al, 2
    mul dl
    add bx, ax
    
    mov ch, cl
    show:
        cmp byte ptr es:[di], 0
        je showok
        mov cl, es:[di]
        mov ds:[bx], cx
        inc di
        add bx, 2
        jmp short show

    showok: 
        pop ds
        pop di
        pop cx
        pop bx
        pop ax
        ret

code ends
end start