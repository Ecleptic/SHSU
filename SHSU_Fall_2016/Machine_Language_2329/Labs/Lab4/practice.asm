;Sabian Pugh
;10/25/16
;Program receives base 10 number and produces 20 random numbers
		org	100h

section .data
msg:	db		0Dh, 0Ah, "Input a number between 1 and 32767: ", '$'
msg2:	db		0Dh, 0Ah, "20 Random Numbers: ", '$'
msg3:	db		0Dh, 0Ah, '$'

section .text
		mov		ah, 9			;load display string fcn
		mov		dx, msg			;load string to be displayed (initial prompt)
		int		21h				;display it

		call	READ			;get a base 10 number in ax
		mov		cx, 20			;set counter to loop 20 times

		push	dx				;save register dx
		push	ax				;save register ax
		mov		ah, 9			;load display string fcn
		mov		dx, msg2		;load string to be displayed (initial prompt)
		int		21h				;display it
		pop		ax				;restore ax
		pop		dx				;restore dx
loop20:
		push	cx				;save the iteration number
		push	dx				;save value of dx
		push	ax				;save value of ax
		mov		ah, 9			;load display string fcn
		mov		dx, msg3		;load string to be displayed (next line)
		int		21h				;print character
		pop		ax				;restore ax
		pop		dx				;restore dx

		call	RANDOM			;turn value into random number
		call	WRITE			;display this random number
		pop		cx				;restore iteration number
		loop	loop20			;do again and decrement cx

		call	exit			;exit DOS

READ:;------------------------------------------------------------------------
		mov		bx, 0			;bx holds input value
		mov		ah, 1			;input char function
		int		21h				;read char into al
top1:							;while (char != CR)
		cmp		al, 0Dh			;is char = CR?
		je		out1			;yes?  finished with input
		and		ax, 000Fh		;convert from ASCII to base 10 value
		push	ax				;and save it on stack
		mov		ax, 10			;set up to multiply bx by 10
		mul		bx				;dx:ax = bx*10
		pop		bx				;saved value in bx
		add		bx, ax			;bx = old bx*10 + new digit
    mov		ah, 1			;input char function
		int		21h				;read next character
		jmp		top1			;loop until done
out1:
		mov		ax, bx			;put value in ax
		ret

WRITE:;--------------------------------------------------------------------
		push	ax				;save value of ax

		xor		cx, cx			;set counter to 0
		mov		bx, 10			;get ready to divide by 10
top2:
		mov		dx, 0			;division setup
		div		bx				;divide ax by 10 (stored in bx)
		push	dx				;save the remainder
		inc		cx				;increment amount of digits to display
		cmp		ax, 0			;is it zero?
		jne		top2			;if not, do it again
loop2:
		pop		dx				;pop off the remainder
		or		dl, 30h			;convert it to ASCII
		mov		ah, 2			;load print char fxn
		int		21h				;print the char
		loop	loop2			;loop until all displayed
		pop		ax				;restore value
ret						;return to which we came

RANDOM:;----------------------------------------------------------------------
		push	bx				;save value in bx
		xor		bx, bx			;clear bx for manipulation

		shl		ax, 1			;shift left for start of procedure
		rcl		ax, 1			;put bit 15 into CF
		jc		one15			;if bit 15 is 1, store it in bh
		jmp		skip			;if not, check bit 14
one15:
		mov		bh, 1			;bh will hold the value of bit 15
skip:
		rcl		ax, 1			;put bit 14 into CF
		jc		one14			;if bit 14 is 1, store it in bl
		jmp		skip2			;if not then skip
one14:
		mov		bl, 1			;bl will hold value of bit 14
skip2:
		rcr		ax, 2			;reset ax to original state
		xor		bh, bl			;finally, xor bh and bl (bits 15 and 14)
		cmp		bh, 0			;check operation result
		je		isZero			;if 0, then clear bit 0
		jmp		notZero			;if not 0, then set bit zero to 1
isZero:
		and		ax, 0FFFEh		;clear bit 0
		jmp		finish			;move on to final step
notZero:
		or		ax, 0001h		;set bit 0 to 1
finish:
		and		ax, 07FFFh		;clear bit 15 as final step
		pop		bx				;restore bx
		ret						;get outa here

;------------------------------------------------------------------------------
exit:
        mov     ah, 04Ch      	; DOS function: Exit program
        mov     al, 0         	; Return exit code value
        int     21h           	; Call DOS. Terminate program
