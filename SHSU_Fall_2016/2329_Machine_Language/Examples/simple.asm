	org	100h
section .text	
	mov	ax,10h
	mov	dx,0
	mov	bx,0
	div	bx
	mov	ax,4C00h
	int 	21h
	