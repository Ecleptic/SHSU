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
	call RANDOM
	; call WRITE

Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program

READ:
; lets the user enter a base 10 integer from the keyboard and returns it value in AX.
	mov	dx,prompt1
	mov	ah,09h 		; print prompt
	int 21h

	; input base 10 value
	mov 	bx,0		; bx holds input value
	mov	ah,1		; input char function
	int	21h		; read char into al
	top1:				; while (char != CR)
		cmp	al,0Dh		; is char = CR?
		je	WRITE		; yes?  finished with input then go write
		and	ax,000Fh	; convert from ASCII to base 10 value
		push	ax		; and save it on stack
		mov	ax,10		; set up to multiply bx by 10
		mul	bx		; dx:ax = bx*10
		pop	bx		; saved value in bx
		add	bx,ax		; bx = old bx*10 + new digit

	  mov	ah,1		; input char function
		int	21h		; read next character
		jmp	top1		; loop until done


ret

WRITE:
;  receives a number in AX and displays that number as a base 10 integer.
	mov	dx,prompt2
	mov	ah,09h 		; print prompt
	int 21h

	dec_out:
		push ax
		push bx
		push cx
		push dx

		cmp bx,0            ; is bx negative?
		jnl skip            ; if not, procede as normal
		mov dl, '-'
		mov ah,2
		int 21h             ; display a minus sign
		neg bx              ; and negate bx (so this is now a positive number. Therefore we have a cleaner algorithm)

	skip:
		mov cx,0
		mov ax,bx           ; setup to divide by 10
		mov bx, 10
	rept1:
		mov dx,0            ; dx:ax is the dividend
		div bx              ; ax is the quotient, dx is remainder
		push dx             ; save the remainder on the stack
		inc  cx             ; increment cx so we can loop back to pop off the stack in the right order
		cmp ax,0            ; is ax = 0?
		jne rept1           ; if not, continue
	for1:
		pop   dx            ; pop digit off stack
		or    dl,30h        ; convert to the ASCII char
		mov   ah,2
		int   21h           ; display the digit
		loop for1           ; loop until cx is 0 (done)

		pop dx              ; restore regs
		pop cx
		pop bx
		pop ax
ret

RANDOM:
;receives a number in AX and returns the next random number in the AX register.
	mov ax,[int]
	shl ax,1
	xor ax, 001111111111111b ;; RCR (or left? ) and pop that bit onto stack. Then xor them both. if it's a 1, then make bit 0 a 1 through a 'mask.'
	mov [int],ax

ret
