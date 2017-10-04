	org 100h
section	.data
str1	db	"Hello, World!$"
section	.bss
str2	resb 	14
section	.text

	cld
	mov	si, str1
	mov	di, str2
	mov	cx, 16
	rep	movsb
	mov	dx,str2
	mov	ah,9
	int	21h