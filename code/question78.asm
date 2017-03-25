assume cs:code, ds:data

data segment
	db 'ibm             '
	db 'dec             '
	db 'dos             '
	db 'vax             '
	dw 0
data ends

code segment
	start:	
		mov ax, data
		mov ds, ax
		
		mov bx, 0

		mov cx, 4
		s1:
			mov ds:[40H], cx
			mov cx, 3
			mov si, 0
			s2:
				mov al, [bx+si]
				and al, 11011111B
				mov [bx+si], al
				inc si
			loop s2
			add bx, 16
			mov cx, ds:[40H]
		loop s1

		mov ax, 4c00h
		int 21h
code ends

end start
