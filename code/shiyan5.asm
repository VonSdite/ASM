assume cs:code

a segment
	db 1,2,3,4,5,6,7,8
a  ends

b segment
	db 1,2,3,4,5,6,7,8
b ends

c segment
	db 0,0,0,0,0,0,0,0
c ends

code  segment
	start:
		mov ax, a
		mov ds, ax

		mov bx, 0
		mov cx, 8
		s:
			mov al, [bx]			;将a段数据放入al
			add al, 16[bx]			;将b段数据与al相加，结果放入al中
			mov 32[bx], al			;将最终结果放入c段
			inc bx
		loop s

		mov ax, 4c00h
		int 21h
code ends

end start