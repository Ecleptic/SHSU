 	org	100h

section .data
number1: dw	42
number2: dw	0x1234
prompt2: db	0Dh,0Ah, "The number is:    $"
prompt3: db	0Dh,0Ah, "In hex it is:     $"

section .text	

	mov	bx, [number1]	; number to be displayed

; bin output	
	mov	ah,9		; print output label
	mov	dx,prompt2
	int 	21h	
	call 	binout

; hex output
	mov	dx,prompt3
	mov	ah,9
	int 	21h
	call 	hexout

	mov	bx,[number2]	
; bin output	
	mov	ah,9		; print output label
	mov	dx,prompt2
	int 	21h	
	call 	binout

; hex output
	mov	dx,prompt3
	mov	ah,9
	int 	21h
	call 	hexout	

Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program

binout:	
	mov	cx, 16		; loop counter
top2:	rol	bx,1		; rotate msb into CF
	jc	one		; CF = 1?
	mov	dl,'0'		; no, set up to print a 0
	jmp	print		; now print
one:	mov	dl,'1'		; printing a 1
print:	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	top2		; loop until done
	ret
	
hexout:	
	mov	cx,4		; loop counter
top3:	rol	bx,4		; rotate top 4 bits into low 4 bits
	mov	dl,bl		; move the hex digit to be printed into dl
	and	dl,0Fh		; max out the top nybble
	cmp	dl,10		; is it 0-9 or A-F?
	jnl	AtoF		; it's A-F -- that's harder
	or	dl,30h		; convert 0-9 to '0'-'9'
	jmp	print2		; ready to display
AtoF:	add	dl,55		; convert A-F to 'A'-'F'
print2: mov	ah,2		; print char fcn
	int 	21h		; display it
	loop	top3		; loop until done
	ret