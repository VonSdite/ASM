assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        
        
        
        
        

        mov ax, 4c00h
        int 21h
    
; ds:si指向存储第一个数的内存空间， 数据有128位，
; ds:di指向存储第二个数的内存空间，结果存储在第一个数的内存空间    
add128:
    push ax
    push cx
    push si
    push di

    sub ax, ax
    mov cx, 8
    s:
        mov ax, ds:[si]
        adc ax, ds:[di] 
        mov ds:[si], ax
        inc si
        inc si
        inc di
        inc di
    loop s
    
    pop di
    pop si
    pop cx
    pop ax
    ret

code ends
end start