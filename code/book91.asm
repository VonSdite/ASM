assume cs:code

code segment
	start:
		mov ax, 0
		jmp short s
		add ax, 1
	s:	
		inc ax

		mov ax, 4c00h
		int 21h
code ends

end start

; assume cs:code

; code segment
; 	start:
; 		s:
; 			mov ax, bx
; 			mov si, offset s
; 			mov di, offset s0
; 			mov dx, cs:[si]
; 			mov cs:[di], dx
; 		s0:
; 			nop
; 			nop
; 		mov ax, 4c00h
; 		int 21h
; code ends

; end start
