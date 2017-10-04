  	org 100h
section .data
  x	dw	5
  y	dw	9
  z	dw	42
prmpt1: db 	"The max is (in hex) = ",'$'
prmpt2: db	0Dh,0Ah,"In base 10 = ",'$'

section .bss
  w	resw	1
section .text

	push	word [z]
	push	word [y]
	push	word [x]
	call	max3	; ax = max of x,y,z
	mov	[w],ax
	
	mov	bx,[w]
	mov	dx,prmpt1   	; print prompt
	mov	ah,9
	int	21h
	
	call 	hex_out

	mov	dx,prmpt2   	; print prompt
	mov	ah,9
	int	21h	
	
	call	dec_out
	mov	ax,4C00h
	int	21h
	
max3:				; max3(x,y,z) returned in ax
	push	bp		; save orig bp
	mov	bp,sp		; set up bp to access params
	mov	ax,[bp+4]	; ax = x
	cmp	ax,[bp+6]	; is x > y?
	jng	else1		; no, then see if y is largest
	cmp	ax,[bp+8]	; is x > z?
	jng	zbig		; z is max
	jmp	done		; x is max, value in ax
else1:	mov	ax,[bp+6]	; ax = y (x has been eliminated)
	cmp	ax,[bp+8]	; compare with z
	jng	zbig		
	jmp	done		; y is largest
zbig:	mov	ax,[bp+8]	; put z (largest) in ax
done:	
	pop	bp		; restore orig bp
	ret	6		; return value in ax and clean up stack
	
hex_out:
; for 4 times do this:
	push	ax		; save registers
	push	cx
	push	dx
	mov	cx, 4		; loop counter
top3:	rol	bx,4		; rotate top nybble into the bottom
	mov	dl,bl		; put a copy in dl
	and	dl,0Fh		; we only want the lower 4 bits
	cmp	dl,9		; is it in [0-9]?
	ja	AtoF2		; if not, process [A-F]
	or	dl,30h		; convert 0-9 to '0'-'9'
	jmp	print2		; now print
AtoF2:	add	dl,55		; convert 10-15 to 'A'-'F' 
print2:	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	top3		; loop until done
	pop	dx
	pop	cx
	pop	ax
	ret
	
dec_out:
	push	ax
	push	cx
	push	dx
	push	bx
	mov	cx,0		; cx counts digits, originally 0
	mov	ax,bx
rept1:
	; we divide bx by 10
	; set up for unsigned division
	mov	dx,0		;
	mov	bx,10		; bx has divisor
	div	bx		; ax = ax/10; dx = ax%10
	push	dx		; save the remainder
	inc	cx		; increment digit counter
	cmp	ax,0		; ax = 0?	
	jne	rept1		
for1:
	pop	dx		; pop digit
	or	dl,30h		; convert to ascii
	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	for1		; repeat for each digit
	
	pop	bx
	pop	dx
	pop	cx
	pop	ax
	
	ret
	
	
