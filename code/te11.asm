assume cs:code

datasg segment
	db "Beginner's All-purpose Symbolic Instruction Code.", 0
datasg ends

code segment
	begin:
		mov ax, datasg
		mov ds, ax

		mov si, 0
		call letterc

		mov ax, 4c00H
		int 21h

; 子程序名称: letterc
; 功能: 将以0结尾的字符串中的小写字母转变成大写字母
; 参数: ds:si指向字符串首地址
letterc:
	push cx
	push si
	mov ch, 0
	change:
		mov cl, ds:[si]
		jcxz ok
		cmp cl, 'a'
		jb skip
		cmp cl, 'z'
		ja skip
		and byte ptr ds:[si], 11011111B
	skip:
		inc si
		jmp short change

	ok:
		pop si
		pop cx
		ret
code ends
end begin