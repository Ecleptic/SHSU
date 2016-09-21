; This is your first programming assignment.
; This program allows the user to input two base-2 integers, subtracts them, and displays their 16-bit difference.
; You will edit this program so that it outputs your name instead of "Inigo Montoya"

	org	100h

;equates section
CR	equ	13
LF	equ	10
EOS	equ	'$'

section .data
prompt0	 db	"Hello, my name is:  Cameron Green, you killed my father, prepare to die!", CR, LF, CR, LF, EOS
prompt1: db	"Please enter a binary number: ", EOS
prompt2: db	"Please enter a second binary number: ", EOS
prompt3: db	CR,LF, "The difference of the two numbers you entered is:    ", EOS

section	.bss
temp:	resw	1


section .text
start:
	mov	ah,9		; print greeting prompt (do not prepare to die)
	mov	dx,prompt0
	int 	21h

	mov	ah,9		; print prompt for first number
	mov	dx,prompt1
	int 	21h

	call	bin_in		; read a binary number into bx
	mov	[temp],bx	; save it in temp location

	mov	ah,9		; print prompt for second number
	mov	dx,prompt2
	int 	21h

	call	bin_in		; read a another binary number into bx
	xchg	bx,[temp]	; swap the two numbers so the second is subtracted from the first
	sub	bx,[temp]	; subtract the saved number from bx

	mov	ah,9		; print output label
	mov	dx,prompt3
	int 	21h

	call	bin_out		; print the sum in bx as binary value


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
	push	ax		; save registers being used
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
	pop	dx		; restore registers
	pop	cx
	pop	ax
	ret			; return to calling procedure
