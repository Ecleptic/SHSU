	org 100h
	section	.data
prompt:	db	"Please enter a character:  $"
outp:	db	0Dh,0Ah,"The character after the one you entered is:  $"
	section .text
; display input prompt
	mov	ah,9		;display $string function
	mov	dx,prompt	;load address of prompt
	int	21h		;display it
; read character from keyboard
	mov	ah,1		;read char function
	int	21h		; reads character into al
; display output message
	mov	ah,9		;display $string function
	mov	dx,outp		;load address of output prompt
	int	21h		;display it	
; display the character
	mov	ah,2		;display char function
	mov	dl,al		; character needs to be in dl
	inc	dl
	int	21h		; display it
; exit to DOS
	mov	ax,4C00h	; ah = exit to DOS function, al = 0 (normal termination)
	int	21h		;  Bye!