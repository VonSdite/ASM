; 显示字符串
; 其中dh代表行，dl代表列
; cl为字体颜色
; data段保存要输出的内容，以0结尾
assume cs:code, ds:data

data segment
	db 'Welcome to masm!', 0
data ends

stack segment
	dw 8 dup (0)
stack ends

code segment
	start:
		mov ax, stack
		mov ss, ax
		mov sp, 10H

		mov dh, 8
		mov dl, 3
		mov cl, 2
		mov ax, data
		mov ds, ax
		mov si, 0
		call show_str

		mov ax, 4c00h
		int 21h

	show_str:
		push ax
		push es
		push dx
		push bx
		push cx
		push si
		mov si, 0

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
			pop si
			pop cx
			pop bx
			pop dx
			pop es
			pop ax
			ret 
	
code ends

end start