assume cs:code

code segment
	mov ax, 1001
	mov bl, 100
	div bl

	mov ax, 4c00h
	int 21h

code ends
end