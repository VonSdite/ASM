assume cs:code, ds:data, ss:stack

stack segment
	dw 0,0,0,0,0,0,0,0
stack ends

data segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
data ends

code segment
	start:	
		mov ax, data
		mov ds, ax
		
		mov ax, stack
		mov ss, ax
		mov sp, 16

		mov bx, 3

		mov cx, 4
		s1:
			push cx
			mov cx, 4
			mov si, 0
			s2:
				mov al, [bx+si]
				and al, 11011111B
				mov [bx+si], al
				inc si
			loop s2
			add bx, 16
			pop cx
		loop s1

		mov ax, 4c00h
		int 21h
code ends

end start
