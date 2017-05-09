assume cs:code


code segment
	sub al,al    
	mov al,10H 
	add al,90H  
	mov al,80H 
	add al,80H  
	mov al,0FCH
	add al,05H  
	mov al,7DH 
	add al,0BH 

	mov ax, 4c00h
	int 21h
code ends
end
