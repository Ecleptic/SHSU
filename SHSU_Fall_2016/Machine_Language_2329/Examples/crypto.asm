; We will read a string,
; and encrypt it, and then decrypt it.

	org 100h
section .data
msg	db	"We attack at dawn",'$'
key	db	0Fh

section	.bss
coded	resb 20
decoded	resb 20

section .text
; while the char != $ encrypt with code int coded
; print the ciphertext
; decode into decoded
; print the recoverd plaintext

	mov	si,0
while1:	
	cmp	byte [si+msg],'$'
	je	endwhile1
	mov	al,[si+msg]
	xor	al,[key]
	mov	[si+coded],al
	inc	si
	jmp	while1
endwhile1:
	
	mov	byte [si+coded],'$'
	
	mov	ah,9
	mov	dx,coded
	int 	21h

	mov	si,0
while2:	
	cmp	byte [si+coded],'$'
	je	endwhile2
	mov	al,[si+coded]
	xor	al,[key]
	mov	[si+decoded],al
	inc	si
	jmp	while2
endwhile2:
	
	mov	byte [si+decoded],'$'
	
	mov	ah,2
	mov	dl,13
	int	21h
	
	mov	dl,10
	int	21h
	
	mov	ah,9
	mov	dx,decoded
	int 	21h

	mov	ax,4C00h
	int	21h	
	

	mov	ax,4C00h
	int	21h	
