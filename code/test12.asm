assume cs:code, ds:data, ss:stack

data segment
	db 'welcome to masm!'
	db 00000010B	;绿字
	db 00100100B	;绿底红字
	db 01110001B	;白底蓝字
data ends

stack segment
	db 16 dup(0)
stack ends

code segment
	start:
		mov ax, stack
		mov ss, ax
		mov sp, 10h

		mov ax, data
		mov ds, ax

		mov ax, 0b872h
		mov es, ax

		mov bx, 0
		mov bp, 10h
		mov cx, 3
		s0:
			push cx
			mov si, 0	
			mov di, 0		
			mov cx, 10h
			s1:
				mov ah, ds:[bp]
				mov al, ds:[si]
				mov es:[bx][di], ax
				add di, 2
				inc si
			loop s1

			add bx, 0a0h
			inc bp
			pop cx
		loop s0			

		mov ax, 4c00h
		int 21h

code ends

end start