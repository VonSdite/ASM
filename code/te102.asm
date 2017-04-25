; 解决除法溢出问题
; 其中被除数是dword型，除数为word型，其结果为dword型
; ax是dword型数据低16位
; dx是dword型数据高16位
; cx是除数
; dx是结果的高16位, ax是结果的低16位
; cx是结果的余数
assume cs:code, ss:stack

stack segment
    dw 8 dup(0)
stack ends

code segment
	start:
	       mov ax, stack 		; 设置栈段
	       mov ss, ax
	       mov sp, 10h

	       mov ax, 4240h 
	       mov dx, 0fh
	       mov cx, 0ah
	       
	       call divdw

	       mov ax, 4c00h
	       int 21h

	divdw:  
	       push ax 				; 将被除数低16位数据L入栈

	       ; 计算int(H/N), 结果保存在bx中
	       mov ax, dx
	       mov dx, 0
	       div cx
	       mov bx, ax

	       pop ax
	       div cx 				
	       mov cx, dx
	       mov dx, bx
	       ret   			
code ends
end start
