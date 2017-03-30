assume cs:code, ds:data

data segment
	dw 0
data ends

code segment
	start:
		mov ax, 100

		mov ax, 4c00h
		int 21h
code ends

end start