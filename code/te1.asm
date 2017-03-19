assume cs:code

code segment

	mov ax, 2000
	mov ds, ax

	mov bl,[0ah]
	mov cl,[2]
	mov dl,[3]

	mov ax, 4c00h
	int 21h

code ends

end