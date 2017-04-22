assume cs:code, ds:data

data segment
	db 'welcome to masm!'
	db '----------------'
data ends

code segment
	start:
		mov ax, data
		mov ds, ax

		mov si, 0

		s:
			mov al, [si]
			mov [si+16], al
			inc si
		loop s

		mov ax, 4c00h
		int 21h
code ends
end start