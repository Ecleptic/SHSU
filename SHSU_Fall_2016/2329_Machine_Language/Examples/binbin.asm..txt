 	org	100h

section .data
prompt1: db	"Please enter a binary number: $"
prompt2: db	0Dh,0Ah, "The number you entered is:    $"

section .text	
start:  
	mov	ah,9		; print prompt
	mov	dx,prompt1
	int 	21h
	
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
	
out1:	mov	ah,9		; print output label
	mov	dx,prompt2
	int 	21h	
	
	mov	cx, 16		; loop counter
top2:	rol	bx,1		; rotate msb into CF
	jc	one		; CF = 1?
	mov	dl,'0'		; no, set up to print a 0
	jmp	print		; now print
one:	mov	dl,'1'		; printing a 1
print:	mov	ah,2		; print char fcn
	int	21h		; print it
	loop	top2		; loop until done


	
Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program

