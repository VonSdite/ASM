assume cs:code
data segment
	db 'welcome to masm!'
data ends

code segment
start:	mov ax,0B800h
	mov ds,ax
	mov ax,data
	mov es,ax
	mov bx,08f2h

	mov cx,8
	mov di,0
s1:	mov al,es:[di]
	mov ah,02h
	mov ds:[bx],ax
	add bx,2
	inc di
	loop s1

	mov cx,3
s2:	mov al,es:[di]
	mov ah,24h
	mov ds:[bx],ax
	add bx,2
	inc di
	loop s2

	mov cx,5
s3:	mov al,es:[di]
	mov ah,71h
	mov ds:[bx],ax
	add bx,2
	inc di
	loop s3

	mov ax,4c00h
	int 21h
code ends
end start
	
