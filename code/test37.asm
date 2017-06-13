assume cs:code

stack segment
    db 128 dup (0)
stack ends

code segment
start:
    mov ax, stack
    mov ss, ax
    mov sp, 128

    push cs
    pop ds

    mov ax, 0
    mov es, ax

    mov si, offset int9
    mov di, 204h
    mov cx, offset int9end - offset int9
    cld
    rep movsb

    push es:[9*4]
    pop es:[200h]
    push es:[9*4+2]
    pop es:[202h]

    cli
    mov word ptr es:[9*4],204h
    mov word ptr es:[9*4+2],0
    sti

    mov ax, 4c00h
    int 21h

int9:
    push ax
    push cx
    push es

    mov ax, 0b800h
    mov es, ax

    in al, 60h

    pushf
    call dword ptr cs:[200h]

    cmp al, 1fh;s的扫描码

    jne int9ret

    mov al, 2
    out 70h, al
    in  al, 71h
    mov ah, al

    mov cl, 4
    shr ah, cl

    and al, 00001111b

    add ah, 30h
    add al, 30h

    mov byte ptr es:[8*160+20*2], ah
    mov byte ptr es:[8*160+21*2], al
    mov byte ptr es:[8*160+20*2+1], 71h
    mov byte ptr es:[8*160+21*2+1], 71h

int9ret:
    pop es
    pop cx
    pop ax
    iret
    
int9end:
    nop

code ends
end start