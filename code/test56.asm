assume cs:code, ds:data

stack segment
    db 128 dup(0)
stack ends

data segment
    time db 9, 8, 7, 4, 2, 0
    sin db '/', '/', ' ', ':', ':'
data ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ax, data
        mov ds, ax
        mov ax, 0b800h
        mov es, ax
        mov si, 12*160+31*2
        mov cx, 6
        mov bx, 0
        s:  
            push cx
            mov al, time[bx]
            out 70h, al
            in al, 71h

            mov ah, al
            and al, 00001111B
            mov cl, 4
            shr ah, cl

            add al, 30h
            add ah, 30h
            mov es:[si], ah
            mov byte ptr es:[si+1], 2
            mov es:[si+2], al
            mov byte ptr es:[si+3], 2

            cmp bx, 5
            je sok 
            mov al, sin[bx]
            mov es:[si+4], al
            mov byte ptr es:[si+5], 2

            add si, 6
            inc bx
            sok:
                pop cx
        loop s
        
        
        mov ax, 4c00h
        int 21h
        
code ends
end start