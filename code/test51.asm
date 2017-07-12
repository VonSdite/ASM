assume cs:code

stack segment
    db 128 dup(0)
stack ends

data segment 
    db 'conversation', 0
data ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ax, cs
        mov ds, ax
        mov si, offset int7ch
        mov ax, 0
        mov es, ax
        mov di, 200h
        mov cx, offset int7ch_end - offset int7ch
        cld
        rep movsb

        mov word ptr es:[7ch*4], 200h
        mov word ptr es:[7ch*4+2], 0


        mov ax, data
        mov ds, ax
        mov si, 0
        int 7ch
        
        
        
        

        mov ax, 4c00h
        int 21h

int7ch:
    push si
int7ch_s:
    cmp byte ptr ds:[si], 0
    je int7ch_iret
    cmp byte ptr ds:[si], 'a'
    jb int7ch_next
    cmp byte ptr ds:[si], 'z'
    ja int7ch_next
    and byte ptr ds:[si], 11011111B
    int7ch_next:
        inc si
        jmp short int7ch_s
    int7ch_iret:
        pop si
        iret
int7ch_end:
    nop

code ends
end start