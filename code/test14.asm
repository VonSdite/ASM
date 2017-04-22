assume cs:code, ds:data

data segment
	db 0
data ends

code segment
	start:
		mov ax, data
		mov ds, ax

		mov ax, 4c00H
		int 21H

code ends
end start