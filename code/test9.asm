assume cs:code, ds:data

data segment
	db 'BaSic'
	db 'iNfOrMaTiOn'
data ends

code segment
	start:
		mov ax, data
		mov ds, ax

		mov bx, 0
		mov cx, 5
		s:
			and byte ptr [bx], 223
			inc bx
		loop s

		mov ax, 4c00h
		int 21h
code ends
end start
