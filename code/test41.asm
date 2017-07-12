assume cs:code, ds:table, ss:stack, es:data

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

table segment
    db 21 dup('year summ ne ?? ')
table ends

stack segment
    dw 16 dup (0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 32

        mov ax, table
        mov ds, ax

        mov ax, data
        mov es, ax

        mov bx, 0
        mov bp, 0
        mov si, 0
        mov cx, 21
        s0:
            push cx
            push si
            mov si, 0
            mov di, 0
            mov cx, 2
            s1:
                push es:[bp][si].0
                pop ds:[bx][di].0

                push es:[bp][si].2
                pop ds:[bx][di].2

                add si, 84
                add di, 5
            loop s1

            pop si
            push es:[si].168
            pop ds:[bx][di]

            mov dx, es:[bp].86
            mov ax, es:[bp].84
            div word ptr es:[si].168
            mov ds:[bx][di+3], ax

            add si, 2
            add bp, 4
            add bx, 16
            pop cx
        loop s0

        mov ax, 4c00h
        int 21h
code ends
end start