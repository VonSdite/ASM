assume cs:code

stack segment
    db 128 dup(0)
stack ends

data segment
    dw 0, 0
data ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ax, data
        mov ds, ax
        mov ax, 0
        mov es, ax
        push es:[9*4]
        pop ds:[0]
        push es:[9*4+2]
        pop ds:[2]

        cli
        mov word ptr es:[9*4], offset int9h
        mov word ptr es:[9*4+2], cs
        sti

        mov ax, 0b800h
        mov es, ax
        mov ah, 'a'
        s:
            mov es:[160*12+40*2], ah
            call delay
            inc ah
            cmp ah, 'z'
            jna s

        mov ax, 0
        mov es, ax

        push ds:[0]
        pop es:[9*4]
        push ds:[2]
        pop es:[9*4+2]

        mov ax, 4c00h
        int 21h

delay:
    push dx
    push ax

    mov dx, 0fh
    mov ax, 0h
    delays:
        sub ax, 1
        sbb dx, 0
        cmp ax, 0
        jne delays
        cmp dx, 0
        jne delays
    pop ax
    pop dx
    ret

int9h:
    push ax
    push bx
    push es

    in al, 60h
    pushf   
    call dword ptr ds:[0]
    cmp al, 01
    jne int9h_ret

    mov ax, 0b800h
    mov es, ax
    inc byte ptr es:[160*12+40*2+1]
int9h_ret:
    pop es
    pop bx
    pop ax
    iret
    
code ends
end start