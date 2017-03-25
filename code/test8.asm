assume cs:code, ds:data

data segment
db 'Basic'
data ends

code segment
	start:
		mov ax, data
		mov ds, ax

		mov bx, 0

		mov cx, 5
		s:
			mov al, [bx]
			and al, 223
			mov [bx], al
			inc bx
		loop s

		mov ax, 4c00h
		int 21h
code ends

end start