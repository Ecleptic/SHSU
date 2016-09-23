;  demo of i/o
section	.data
prompt	db	"Please input a char: $"
output	db	13,10,"The character after the one you input was:  $" 
section .bss
char	resb	1
	org 	100h
section .text
;  print a prompt telling user what to do
	mov	ah,9		; display $ string function
	mov	dx, prompt	; load dx with ADDRESS of prompt
	int	21h		; display the prompt
;  read a char from keyboard
	mov	ah,1		; read char fcn
	int	21h		; read char into al
	inc	al		; next char
	mov	[char],al	; save it someplace safe
; display character on the next line
	mov	ah,9		; display string fcn
	mov	dx, output	; address of output label
	int	21h		; display it
	mov	ah,2		; display char fcn
	mov	dl,[char]	; get ready to display char read earlier
	int	21h		; display it
; exit to DOS
	mov	ah,4Ch		; program termination fcn
	mov	al,0		; normal termination
	int	21h		; return to DOS