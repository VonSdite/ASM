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
        
int7ch:
    push bp
    mov bp, sp
    add ss:[bp+2], bx
    pop bp
    iret
int7ch_end:
    nop 
code ends
end start