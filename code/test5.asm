assume cs:code, ds:data

data segment
	db "H e l l o  w o r l d !"
data ends

code segment
	start:
		mov ax, 0b888h
		mov ds, ax

		mov ax, data
		mov es, ax

		mov bx, 0

		mov cx, 22
		s:
			mov ax, es:[bx]
			mov [bx], ax
			inc bx
			loop s

		mov ax, 4c00h
		int 21h
code ends

end start