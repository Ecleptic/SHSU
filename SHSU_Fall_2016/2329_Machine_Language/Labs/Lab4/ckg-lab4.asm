org	100h

section .data
CR: db  0Dh,0Ah ,'$'
prompt1: db 'Enter a base 10 integer: $'
prompt2: db 'The base 10 integer is: $'
int: db '' ,'$'

exCode: db 0,"$"

section .text
start:
	call READ
	call WRITE

Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program

READ:
; lets the user enter a base 10 integer from the keyboard and returns it value in AX.
	mov	dx,prompt1
	mov	ah,09h 		; print prompt
	int 21h

	mov	ah,1		; input char function
	int	21h		  ; read char into al

	mov	dx,CR
	mov	ah,09h 		; print carriage return
	int 21h

	mov [int],ax ;save ax into int.
ret

WRITE:
;  receives a number in AX and displays that number as a base 10 integer.
	mov	dx,prompt2
	mov	ah,09h 		; print prompt
	int 21h

	mov ax,int
	mov	dx, ax
	mov	ah,09h 		; print the number from READ
	int 21h
ret

RANDOM:
;receives a number in AX and returns the next random number in the AX register.

ret
