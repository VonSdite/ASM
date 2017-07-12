assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        pushf
        pushf
        pop bx
        and bh, 11111100B
        popf
        call dword ptr ds:[0]

        mov ax, 4c00h
        int 21h
        
code ends
end start