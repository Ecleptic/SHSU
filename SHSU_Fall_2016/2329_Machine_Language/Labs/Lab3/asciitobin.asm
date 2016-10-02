org	100h

section .data
prompt1: db	"Please enter a  letter: $"

prompt2: db	0Dh,0Ah, "In binary, the number you entered is:    $"


section .text
top1:				; while (char != CR)
mov	ah,9		; print prompt
mov	dx,prompt1
int 	21h

mov 	bx,0		; bx holds input value
mov	ah,1		; input char function
int	21h		; read char into al

; now, output it in binary

	mov      ds, ax
	; mov      al, a             ; Load number1 in al
	mov      cl , 08H
	mov      ah, 00h           ; ah=00
	up :     shl      al, 01h       ; divide the number by 2 and SHL gives the same result
	mov      bl, al
	mov      al, 00H
	adc      al, 30h
	mov      dl, al
	mov      ah, 02h
	int      21h
	mov      al,bl
	dec      cl
	jnz      up

Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program
