assume cs:code

stack segment
    db 128 dup(0)
stack ends

code segment
    start:
        mov ax, stack
        mov ss, ax
        mov sp, 128

        mov ax, 180
        call  SHOWSIN
        
        
        
        

        mov ax, 4c00h
        int 21h
    
    ; 用AX向SHOWSIN传递角度
    SHOWSIN:
        JMP SHORT SHOW
        TABLE DW AG0, AG30, AG60, AG90, AG120, AG150, AG180  ; 字符串偏移地址表
        AG0   DB '0', 0                ; sin(0)对应的字符串"0"
        AG30  DB '0.5', 0              ; sin(30)对应的字符串"0.5"                
        AG60  DB '0.866', 0            ; sin(60)对应的字符串"0.866"    
        AG90  DB '1', 0                ; sin(90)对应的字符串"1"
        AG120 DB '0.866', 0            ; sin(120)对应的字符串"0.866"    
        AG150 DB '0.5', 0              ; sin(150)对应的字符串"0.5"    
        AG180 DB '0', 0                ; sin(180)对应的字符串"0"
    
    SHOW:
        push ax
        push bx
        push es
        push si

        cmp ax, 180
        ja error

        mov ah, 0
        mov bl, 30
        div bl
        cmp ah, 0
        jne error

        mov bx, 0b800h
        mov es, bx
        mov si, 12*160+36*2

        mov bx, ax
        add bx, bx
        mov bx, TABLE[bx]

        showangle:
            cmp byte ptr cs:[bx], 0
            je showret
            mov al, cs:[bx]
            mov es:[si], al
            mov byte ptr es:[si+1], 2
            add si, 2
            inc bx
            jmp short showangle

        error:
            jmp short ee
            eee db 'Error angle!', 0
        ee:
            mov bx, 0b800h
            mov es, bx
            mov si, 12*160+36*2
            mov bx, 0
            eeshow:
                cmp byte ptr eee[bx], 0
                je showret
                mov al, eee[bx]
                mov es:[si], al
                mov byte ptr es:[si+1], 2
                inc bx
                add si, 2
                jmp short eeshow

        showret:
            pop si
            pop es
            pop bx
            pop ax
            ret

code ends
end start