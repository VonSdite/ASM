assume cs:code

code segment
    start:
        mov ax, cs
        mov ds, ax
        mov si, offset do0      ;将要被传送的代码地址

        mov ax, 0
        mov es, ax
        mov di, 200H            ;代码复制的目的地址
        
        ; 要复制的代码长度
        mov cx, offset do0end - offset do0
        cld
        rep movsb

        ;设置中断向量表
        mov word ptr es:[0*4], 200H
        mov word ptr es:[0*4+2], 0

        mov ax, 4c00H
        int 21H

    do0: ;这里的段地址是0, 偏移地址是200H,即传送的目的地
        jmp short do0start
        db "overflow!", 0       ;显示的字符串，以0为结尾
    do0start:
        mov ax, 0B800H
        mov es, ax
        mov di, 12*160+36*2
        ; 设置显存以及显示的位置

        mov ax, cs
        mov ds, ax
        mov si, 202H
        ;202H是因为jmp short 占两个字节

        mov ch, 0
    not0:
        mov cl, ds:[si]
        jcxz ok
        mov es:[di], cl
        mov byte ptr es:[di+1], 7   ;颜色属性
        inc si
        add di, 2
        jmp short not0 
    ok:
        mov ax, 4c00H
        int 21H
    do0end: nop

code ends
end start