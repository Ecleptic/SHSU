;Name: Justin Jones
;Date: 10/17/2016
;Description: The program will read a base-10 integer into AX using mul, and use a loop 
;			and div procedure to print integers to the screen. It will also generate 
;			random numbers based on input in AX, and in general utilize the stack to 
;			temporarily save values when performing operations with registers.

						org	100h
section		.data
	random	dw	7238
	prompt 	db	"Enter a number in base 10: $"
	label	db	"The number you entered was: $"
	rand 	db	13, 10, "20 random numbers: $"
	crlf	db	13, 10, '$'
	
section 	.text
;main body
	call	READ	;call input function
	push	ax		;save ax
	mov		ah, 9	;print string fcn
	mov		dx, label;number label
	int		21h		;print label
	pop		ax		;restore ax
	call	WRITE	;output a base-10 value
	mov		cx, 20	;loop count
	push	ax		;save ax
	mov		ah, 9	;print string fcn
	mov		dx, rand;random # label
	int		21h		;display it
	pop		ax		;restore ax
	
top:				;begin for loop
	call	RANDOM	;generate random #
	push	ax		;save ax
	mov		ah, 9	;display string fcn
	mov		dx, crlf	;print cr/lf for readability
	int		21h		;print it
	pop		ax		;restore value to ax
	call	WRITE	;output # in AX
	loop	top		;for 20 times, generate/write random #
					;end for loop
	jmp		exit	;done!
;end main body

;will read char until CR, convert to numeric and add
READ:				
	mov		ah, 9	;display string fcn
	mov		dx, prompt	;string to display
	int		21h		;display it
	mov		ah, 1	;read char fcn
	xor		bx, bx	;clear bx for use
	int		21h
while1:	
	cmp		al, 0Dh	;check for carriage return
	je 		endwhile1;if CR, exit
	push	ax		;save register for input
	mov		ax, 10	;to multiply
	mul		bx		;= 10*bx
	xchg	ax, bx	;lower word in ax put in bx
	pop		ax		;restore register values
	and		ax, 0000Fh;clear upper half of ax
	add		bx, ax	;add original input into 
	mov		ah, 1	;read char fcn
	int		21h		;read next char
	jmp		while1	;repeat until CR
endwhile1:
	xchg	ax, bx	;restore number to ax
	ret				;back to main body
;end READ, value in AX

;will take value from AX and print
WRITE:
	push	ax		;push to save/restore afterwards
	push	bx		;save register
	push	cx		;save loop count
	push 	dx		;save register
	mov		bx, 10	;div by bx
	xor		cx, cx	;clear cx for count
while2:
	mov		dx, 0	;setup division - upper half 0
	div		bx		;begin division
	push 	dx		;save remainder to stack
	inc		cx		;increment counter for pop display
	cmp 	ax, 0	;check if quotient is 0
	jne 	while2	;cont if not 0
	mov		ah, 2	;print char fcn
loop1:
	pop 	dx		;pop then print
	or		dl, 30h	;clear top half of dx
	int		21h		;print it
	loop 	loop1	;loop times of cx
	pop 	dx		;restore register
	pop		cx		;restore loop count	
	pop		bx		;restore register
	pop		ax		;restore value
	ret				;return to main prog
;end WRITE, orig value in AX

;will generate random numbers based upon input in AX	
RANDOM:
	push	bx		;save bx to stack
	xor		bx, bx	;clear bx for use
	shl		ax, 1	;shift left to set bit 0 later
	rcl		ax, 1	;bit 15 now CF
	jc		one		;if CF 1, set bh to 1
	jmp		next	;else check bit 14
one:mov		bh, 1	;bh holds value of bit15
next:rcl	ax, 1	;bit 14 now CF
	jc		one2	;if CF 1, set bl to 1
	jmp 	next2	;otherwise move on
one2:mov	bl, 1	;bl holds value of bit14
next2:rcr	ax, 2	;reset to original value
	xor		bh, bl	;perform xor op, then set bit 0 to result
	cmp		bh, 0	;check result of xor
	je		zero	;if 0, clear bit 0
	jmp		not0	;if 1, set bit 0
zero:
	and		ax, 0FFFEh	;clear bit 0 -> 1111111111111110b
	jmp		bottom		;skip set
not0:or		ax, 00001h	;set bit 0 -> 0000000000000001b
bottom:	
	and		ax, 07FFFh	;clear bit 15 -> 0111111111111111b
	pop		bx			;restore bx
	ret
;end RANDOM, value in AX

exit:
	mov	ah,4Ch		;terminate program function
	mov	al,0		;exit condition normal
	int	21h			;out