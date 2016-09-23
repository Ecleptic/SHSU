	org	100h
	
section .data
prompt1: db	"Please enter a binary number: $"
prompt2: db	0Dh,0Ah, "In base 2, the number you entered is:    $"
prompt3: db	0Dh,0Ah, "In base 16, the number you entered is:    $"

section .text	
start:  
	mov	ah,9		; print prompt
	mov	dx,prompt1
	int 	21h
	
	call	bin_in		; read a binary number into bx
	
	mov	ah,9		; print output label
	mov	dx,prompt2
	int 	21h	

	call	bin_out		; print the number in bx as binary value
	
	mov	ah,9		; print output label
	mov	dx,prompt3
	int 	21h
	
	call	hex_out		; print the number as a hex value
	
Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program

;	procedure to read a value in binary from keyboard into bx
bin_in:
	push	ax		; save ax for later restoration
	mov 	bx,0		; bx holds input value
	mov	ah,1		; input char function
	int	21h		; read char into al
top1:	cmp	al,0Dh		; is char = CR?
	je	out1		; yes?  finished with input
	sal	bx,1		; bx *= 2
	and	al,01h		; converts ASCII to binary value
	or	bl,al		; "adds" the input bit
	int	21h		; read next character
	jmp	top1		; loop until done
out1:	pop	ax		; restore reg
	ret			; return with input value in bx
	

;	procedure to print the value in bx as a base 2 number	
bin_out:
	push	ax		; save register being used
	push	cx
	push	dx
	mov	cx, 16		; loop counter
top2:	rol	bx,1		; rotate msb into CF
	jc	one		; CF = 1?
	mov	dl,'0'		; no, set up to print a 0
	jmp	print		; now print
one:	mov	dl,'1'		; printing a 1
print:	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	top2		; loop until done
	pop	dx		; restore regs
	pop	cx
	pop	ax
	ret

;	procedure to print the value in bx as a hexadecimal number
hex_out:
	push	ax		; save regs
	push	cx
	push	dx
	mov	cx,4		; loop 4 times
top3:	rol	bx,4		; rotate current digit into the low 4 bits
	mov	dl,bl		; move to dl
	and	dl,0Fh		; mask out top bits
	cmp	dl,9		; is it 0..9 or A..F?
	jg	AtoF		; if A..F, process later
	or	dl,30h		; convert 0..9 to '0'..'9'
	jmp	display		; go to display code
AtoF:	add	dl,55		; convert to 'A'..'F'
display:
	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	top3		; loop until done
	pop	dx		; restore regs
	pop	cx
	pop	ax
	ret			; we are finished
	
	
