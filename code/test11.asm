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
  dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

code segment
  start:
    mov ax, data
    mov es, ax

    mov ax, table
    mov ds, ax

    mov ax, stack
    mov ss, ax
    mov sp, 10h

    mov bx, 0
    mov bp, 0
    mov di, 0
    mov cx, 21
    s0:
      push cx
      mov si, 0
      mov cx, 2
      s1:
        push es:0[bp][si]
        pop ds:[bx].0[si]
        add si, 2
      loop s1

      mov si, 0
      mov cx, 2
      s2:
        push es:84[bp][si]
        pop ds:[bx].5[si]
        add si, 2
      loop s2

      push es:168[di]
      pop ds:[bx].10

      mov ax, ds:[bx].5
      mov dx, ds:[bx].7
      div word ptr ds:[bx].10
      mov ds:[bx].13, ax

      pop cx
      add bx, 16
      add bp, 4
      add di, 2
      loop s0

      mov ax, 4c00h
      int 21h
code ends

end start
