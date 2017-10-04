;	This program illustrates i/o functions in NASM

	org 100h	; program start point
section .data
msg	db	"Enter a character, please -->  ",'$'
msg2	db	13,10,"Your character was:  ",
char	db	' '
	db	13,10,'$'


section .text
	mov	dx, msg	; offset addr of message to display
	mov	ah, 9	; print string function
	int	21h	; print message
	
	mov	ah, 1	; read char function
	int	21h	; read character into al
	
	mov	[char],al	; store character in ch
	
	mov	dx, msg2 ; offset of 2nd message
	mov	ah, 9	; print string function
	int	21h	; print it
	
;	mov	dl,[char]	; char to display
;	mov	ah, 2		; print char function
;	int	21h		; display it
	
	mov	ah, 4Ch		; exit to DOS function
	int	21h		; bye!
