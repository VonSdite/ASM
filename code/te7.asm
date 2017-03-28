assume cs:code, ds:table, ss:stack, es:data

data segment
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983', '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992', '1993', '1994', '1995'
	;以上是表示21年的21个字符串

	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
	;以上是表示21年公司总收入的21个dword型数据

	dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
	;以上是表示21年公司雇员人数的21个word型数据
data ends

table segment
	db 21 dup('year summ ne ?? ')
table ends

stack segment
	dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

code segment
	start:
		mov ax, table
		mov ds, ax								;设置存放数据的table段

		mov ax, data
		mov es, ax								;设置取数据的data段

		mov ax, stack
		mov ss, ax
		mov sp, 16 								;设置临时存放数据的栈段

		mov bx, 0								;table的行的初始地址
		mov bp, 0								
		mov di, 0								

		mov cx,21
		s0:
			push cx
			mov cx, 2
			mov si, 0
			s1:									;将年份输入到table中
				push es:[bp].0[si]
				pop [bx].0[si]
				add si, 2
			loop s1
			mov byte ptr [bx].0[si], ' '		;输出空格

			mov cx, 2
			mov si, 0
			s2:
				push es:[bp].84[si]
				pop [bx].5[si]
				add si, 2
			loop s2 							;将收入输入到table中

			mov byte ptr [bx].5[si], ' '		;输出空格

			push es:[di].168
			pop word ptr [bx].10				;将雇员数输入到table中
			mov byte ptr [bx].12, ' '			;输出空格

			mov ax, [bx].5[0]
			mov dx, [bx].5[2]
			div word ptr [bx].10 				;计算人均收入
			mov word ptr [bx].13, ax			;将人均收入输入到table中
			mov byte ptr [bx].15, ' ' 			;输出空格

			add bx, 16
			add bp, 4
			add di, 2
			pop cx
		loop s0

		mov ax, 4c00h
		int 21h
code ends

end start