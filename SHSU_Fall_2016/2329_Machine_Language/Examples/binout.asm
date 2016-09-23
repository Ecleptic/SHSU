 	org	100h

section .data
number:  dw	42	
prompt2: db	"The number  is:    $"

section .text	
start:  

	mov	bx,[number]	; number to display
	
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

