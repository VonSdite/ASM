;在屏幕中间分别显示绿色,绿底红色,白底蓝色字符串"welcome to masm!"
assume cs:code, ds:data, ss:stack

data segment
    db 'welcome to masm!'
    db 00000010B            ;绿字
    db 00100100B            ;绿底红字
    db 01110001B            ;白底蓝字
data ends

stack segment
    db 8 dup(0)
stack ends

code segment
    start:    
        mov ax, data
        mov ds, ax              ;设置数据段
        
        mov ax, stack
        mov ss, ax
        mov sp, 10H             ;设置临时存储数据栈段
        
        mov ax, 0B872H          ;0B828H屏幕显示第一个位置
        mov es, ax              ;设置显示区域
        
        mov bx, 0               ;用于表示输出的行
        mov bp, 10h             ;用于指向颜色位置
        
        mov cx, 3
    s0: 
        push cx
        
        mov si, 0
        mov di, 0               ;表示每行字符的位置
        mov cx, 10h
        s1: 
            mov al, ds:[si]
            mov ah, ds:[bp]
            mov es:[bx+di], ax
            inc si
            add di, 2
        loop s1
        
        inc bp
        add bx, 0a0h
        pop cx
    loop s0

        mov ax, 4c00h
        int 21h

code ends

end start