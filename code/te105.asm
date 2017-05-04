assume cs:code, ss:stack, ds:data

;******************
;  数据段、栈段	  *
;******************
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

stack segment
	dw 128 dup (0)
stack ends

; 用于临时存储要显示的十进制数的字符串
da segment
 	dw 2 dup(0)
da ends

;******************
;  程序的主体	  *
;******************
code segment
	main:
		call init
		; mov ax, stack 			;设置栈段
		; mov ss, ax
		; mov sp, 100H

		; mov ax, data 			;设置数据段
		; mov ds, ax

		; mov ax, 0B828H 			;设置显存位置
		; mov es, ax
		
		; mov bp, 8 				;设置每行显示开始在第5列				
		; mov bx, 0 				

		mov cx, 21 				;共21行
		s0:
			push cx
			call printf
			add bp, 0A0H 		;下一行
			add bx, 4 			
			pop cx
		loop s0

		mov ax, 4C00H
		int 21H

;******************
;  定义的函数	  *
;******************
init:
	mov ax, stack 			;设置栈段
		mov ss, ax
		mov sp, 100H

		mov ax, data 			;设置数据段
		mov ds, ax

		mov ax, 0B828H 			;设置显存位置
		mov es, ax
		
		mov bp, 8 				;设置每行显示开始在第5列				
		mov bx, 0 		
	ret
space:
	push cx
	mov cx, 4
	blank:
		mov word ptr es:[bp], 20H
		add bp, 2
	loop blank
	pop cx
	ret

printf:
	push bp
	mov di, 0
	mov ah, 2 				;显示的颜色属性

	; 年份
	mov cx, 4
	s1:
		mov al, ds:[bx].0[di]
		mov es:[bp], ax
		inc di
		add bp, 2
	loop s1

	; 分隔
	call space

	;公司总收入
	mov ax, ds:[bx].84
	mov dx, ds:[bx].86
	call dtoc
	call show_str

	pop bp
	ret

; 函数dtoc
; 将dword型数据转变为表示十进制数的字符串，字符串以0为结尾符
; 参数dword型数据，dx表示高16位数据，ax表示低16位数据，字符串放入在da段中
dtoc:
	push si
	push cx
	push bx
	push dx
	push di
	push ds
	push bx
	mov bx, da
	mov ds, bx
	mov word ptr ds:[0], 0
	mov word ptr ds:[2], 0
change: 	; 用于十进制数转换为字符串
	mov cx, 10
	call divdw 			;每次将值除以10
	push cx

	mov cx, ax 			;判断商低16位是否为0
	jcxz ok1			;为0则向下继续判断高16位是否为0
	jmp short flag 		;不为0的话，则继续除以10

ok1:					;在低16位为0的情况下继续判断高16位
	mov cx, dx
	jcxz ok0 			;判断商是否为0，是则停止除以10

flag: 					;商不为0的情况
	pop cx
	add cx, 30H
	push cx  			;由于除以10的结果是低位先出，先压入栈，之后需再逆序
	inc si
	jmp short change
ok0: 					;商为0的情况
	pop cx
	add cx, 30H
	push cx
	inc si
	mov di, 0 		
	mov cx, si
	s: 					;将其逆序
		pop ax
		mov ds:[di], al
		inc di
	loop s
	mov byte ptr ds:[si], 0 	;设置字符串结尾符
	pop bx
	pop ds
	pop di
	pop dx
	pop bx
	pop cx
	pop si
	ret

; 解决除法溢出问题
; 其中被除数是dword型，除数为word型，其结果为dword型
; ax是dword型数据低16位
; dx是dword型数据高16位
; cx是除数
; dx是结果的高16位, ax是结果的低16位
; cx是结果的余数
divdw:  
	push bx	
    push ax 			; 将被除数低16位数据L入栈

    ; 计算int(H/N), 结果保存在bx中
    mov ax, dx
    mov dx, 0
    div cx
    mov bx, ax

    pop ax
    div cx 				
    mov cx, dx
    mov dx, bx
    pop bx
    ret

; 显示字符串
; 显示的位置从bp处开始
; da段保存要输出的内容，以0结尾
show_str:
	push ax
	push cx
	push si
	push ds

	mov ax, da
	mov ds, ax
	mov si, 0

	;颜色用ah寄存器保存
	mov ah, 2

	mov ch, 0 		; 通过判断cx是否为0来结束循环，需将ch设置为0
	print:
		mov cl, ds:[si]
		jcxz ok
		mov al, ds:[si]
		mov es:[bp], ax
		inc si
		add bp, 2
	jmp short print
	ok: 
		mov ax, 14
		sub ax, si
		mov cx, ax
		s11:
			mov word ptr es:[bp], 20H
		loop s11
		pop ds
		pop si
		pop cx
		pop ax
		ret 

code ends
end main