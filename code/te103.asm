assume cs:code

data segment
	db 10 dup (0)
data ends

stack segment
 	dw 32 dup(0)
stack ends

code segment
	start:
		mov ax, stack
		mov ss, ax
		mov sp, 40H

		mov ax, 65535
		mov bx, data
		mov ds, bx
		mov si, 0
		call dtoc

		mov dh, 8
		mov dl, 3
		mov cl, 2
		call show_str

	; 函数dtoc
	; 将word型数据转变为表示十进制数的字符串，字符串以0为结尾符
	; 参数(ax)=word型数据， ds:si指向字符串的首地址	
	dtoc:
		push si
		push cx
		push bx
		push dx
		push di
	change:
		mov cx, 10
		mov dx, 0
		call divdw 			;每次将值除以10
		push cx
		mov cx, ax
		jcxz ok0 			;判断商是否为0，是则停止除以10
		pop cx
		add cx, 30H
		push cx  			;由于除以10的结果是低位先出，先压入栈，之后需再逆序
		inc si
		jmp short change
	ok0:
		pop cx
		add cx, 30H
		push cx
		inc si
		mov di, 0 		
		mov cx, si
		s:
			pop ax
			mov ds:[di], al
			inc di
		loop s
		mov byte ptr ds:[si], 0 	;设置字符串结尾符
		pop di
		pop dx
		pop bx
		pop cx
		pop si
		ret

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

	show_str:
		push ax
		push es
		push dx
		push bx
		push cx

		; 设置显存段地址
		mov ax, 0b800h
		mov es, ax

		; 处理位置, 最终位置保存在bx中，作为偏移地址使用
		dec dl			; 设置列
		mov al, 2 		
		mul dl
		mov bx, ax
		
		mov al, 160		; 设置行
		dec dh
		mul dh
		add bx, ax

		;颜色用ah寄存器保存
		mov ah, cl

		mov ch, 0 		; 通过判断cx是否为0来结束循环，需将ch设置为0
		print:
			mov cl, [si]
			jcxz ok
			mov al, ds:[si]
			mov es:[bx+si], ax
			inc si
			inc bx
		jmp short print
		ok: 
			pop cx
			pop bx
			pop dx
			pop es
			pop ax
			ret 
	
code ends
end start