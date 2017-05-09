; 两个128位数据相加
add128:
	push ax
	push cx
	push si
	push di

	sub ax, ax		;将CF置零

	mov cx, 8
	s:
		mov ax, [si]
		adc ax, [di]
		mov [si], ax
		inc si			;避免产生进位
		inc si
		inc di
		inc di
	loop s

	pop di
	pop si
	pop cx
	pop ax
	ret 