assume cs:code, ds:data

data segment
    db 'BaSiC'
    db 'iNfOrMaTiOn'
data ends

code segment
    start:
        mov ax, data
        mov ds, ax
        mov bx, 0
        mov cx, 5
        s0:
            and byte ptr ds:[bx], 11011111B
            inc bx
        loop s0

        mov cx, 11
        s1:
            or byte ptr ds:[bx], 00100000B
            inc bx
        loop s1

        mov ax, 4c00h
        int 21h
code ends

end start