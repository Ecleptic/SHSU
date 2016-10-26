org	100h

section .data
CR: db  0Dh,0Ah ,'$'
prompt1: db 'Enter a base 10 integer from 1 to 32767: $'
prompt2: db 'The base 10 integer is: $'
prompt3: db 'The 20 random integers are: $'
int: db '' ,'$'

exCode: db 0,"$"

section .text
Start:
	call READ
	push ax
	mov	ah,09h 		; randoms are: prompt
	mov	dx,prompt3
	int 21h
	pop	ax				;restore ax

	mov cx,20 						; randomize 20 numbers, count = 20;
	
Loopx20:
	push cx 				; to make sure count doesn't get screwed up push
	call RANDOM
	push ax
	mov	ah,09h
	mov	dx,CR 		;carriage return
	int 21h
	pop ax
	call WRITE
	pop cx					;now pop it and loop
	loop Loopx20


Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program

READ:
; lets the user enter a base 10 integer from the keyboard and returns it value in AX.
	mov	dx,prompt1
	mov	ah,09h 		; input prompt
	int 21h

	; input base 10 value
	mov 	bx,0		; bx holds input value
	mov	ah,1		; input char function
	int	21h		; read char into al

	top1:				; while (char != CR)
		cmp	al,0Dh		; is char = CR?
		je	fin		; yes?  finished with input then go fin and quit.
		and	ax,000Fh	; convert from ASCII to base 10 value
		push	ax		; and save it on stack
		mov	ax,10		; set up to multiply bx by 10
		mul	bx		; dx:ax = bx*10
		pop	bx		; saved value in bx
		add	bx,ax		; bx = old bx*10 + new digit

	  mov	ah,1		; input char function
		int	21h		; read next character
		jmp	top1		; loop until done

fin: ;finished. go return.
	xchg		ax, bx			;put value back into ax

ret

WRITE:
;  receives a number in AX and displays that number as a base 10 integer.
	push ax                        ; push to stack
	push bx
	push cx
	push dx


	skip:
		xor cx, cx
		; mov cx,0
		; mov ax,bx           ; setup to divide by 10
		mov bx, 10

	rept1:
		mov dx,0            ; dx:ax is the dividend
		div bx              ; ax is the quotient, dx is remainder
		push dx             ; save the remainder on the stack
		inc  cx             ; increment cx so we can loop back to pop off the stack in the right order
		cmp ax,0            ; is ax = 0?
		jne rept1           ; if not, continue
		mov ah,2

	for1:
		pop   dx            ; pop digit off stack
		or    dl,30h        ; convert to the ASCII char
		mov   ah,2
		int   21h           ; display the digit
		loop for1           ; loop until cx is 0 (done)

		pop dx
		pop cx
		pop bx
		pop ax	                     	; restore value

ret

RANDOM:
;receives a number in AX and returns the next random number in the AX register.
	push bx								; push bx to stack for later use
	xor bx,bx  						;clear out bx just in case.

	shl ax,1 						; shift left for bit zero
	rcl ax,1 						; bit 15 is in the carry flag
	jc c15						; if carry is 1 then set bh to 1
	jmp skip1 				; if not, skip.

	c15:
		mov bh,1				; bh holds bit 15

	skip1:
		rcl ax,1					; rotate left to put bit 14 in the carry flag
		jc 	c14						;if carry is 1 set bl to 1. then I can xor bl and bh.
		jmp skip2					; if not, then carry on.

	c14:
			mov bl,1					; bl holds bit 14. we're about to xor them.

	skip2:
		rcr ax,2 		;undo our previous carrys, we've got those two bits.
		xor bh,bl 			;sets bit zero
		cmp bh,0				; is the xor a zero?
		je 	zero				; if it IS zero. then clear bit zero in zero
		jmp	notZero			; otherwise, cry a little and set bit zero.

	zero:
		and ax, 1111111111111110b ;clearing out bit zero
		jmp finish		; so we don't set what we just skipped

	notZero:
		or ax, 0000000000000001b ;setting bit 0

	finish:
		and ax, 0111111111111111b ;now clear bit 15
		pop bx			; put bx back

ret
