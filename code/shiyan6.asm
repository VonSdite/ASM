assume cs:code, ss:stack, ds:data

stack segment
	dw 0,0,0,0,0,0,0,0
stack ends

data segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
data ends

code segment
   start:
   		mov ax, data
   		mov ds, ax				

   		mov ax, stack
   		mov ss, ax
   		mov sp, 16

   		mov bx, 0				;设置起始行偏移地址
   		mov cx, 4 				
   		s0:
   			push cx
   			mov si, 3			;设置起始列偏移地址
   			mov cx, 2
   			s1:
   				and word ptr [bx][si], 0DFDFH
   				add si, 2 		;下一列 	
   			loop s1

   			add bx, 16			;下一行
   			pop cx
   		loop s0

   		mov ax, 4c00h
   		int 21h

code ends

end start