assume cs:code


data segment
    db "welcome to masm! ", 0
data ends

stack segment
    dw 8 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 10h

        mov dh, 10
        mov dl, 10
        mov cl, 2
        mov ax, data
        mov ds, ax
        mov si, 0
        int 7ch

        mov ax, 4c00h
        int 21h
code ends

end start