assume cs:code, ds:data

data segment
	db 1+'0',2+'0',3+'0',4+'0',5+'0',6+'0',7+'0',8+'0',9+'0',10+'0',11+'0',12+'0',13+'0',14+'0',15+'0',16+'0',17+'0',18+'0',19+'0',20+'0',21+'0',22+'0',23+'0',24+'0',25+'0'

save segment
	dw 4 dup(0)
save ends

code segment
	start:
		mov ax, data
		mov ds, ax

		mov cx, 25
		mov dl, 1
		mov dh, 1
		mov si, 0
		s:
			call show_str
			inc dh
			inc si
		loop s

	show_str:
		push cx
		push dx
		push bx
		push ax
		push es
		; 设置显存段地址
		mov ax, 0b800h
		mov es, ax

		; 处理位置, 最终位置保存在bx中，作为偏移地址使用
		mov bx, 0
		
		mov ax, 160		; 设置行
		dec dh
		mov dl, dh
		mov dh, 0
		mul dx
		add bx, ax

		;颜色用ah寄存器保存
		mov ah, 2
		
		mov al, ds:[si]
		mov es:[bx+si], ax
		inc si
		inc bx
	
		
		pop es
		pop ax
		pop bx
		pop dx
		pop cx
		ret 
code ends
end start