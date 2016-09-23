; palindrome program
	org 100h
CR	equ	13
NULL	equ	0

section	.bss	
string1	resb	80
string2	resb	80
section	.data
CRLF	db	CR,10,'$'
yesmsg	db	"is a palindrome",CR,10,'$'
nomsg	db	"is NOT a palindrome",CR,10,'$'


section	.text
; input a char from kbd into string1
	mov	cx,0		; CX count chars, initially zero
	cld			;process string left to right
	mov	di,string1	; string1 is destination
	mov	ah,1		; read char fcn
	int	21h		; read it
while1: cmp	al,CR		; is char = CR?
	je	endwhile1	; if so, exit loop
	inc	cx
	stosb			; store char just read into string1
	int	21h		; read next char
	jmp	while1		; loop until done
endwhile1:
	mov	byte [di],NULL	; store ASCII null char
	
	mov	dx,string1	; dx is the address arg to print
	call	print		; print string1

	call	reverse		; copies string1 into string2 reversed
	mov	dx,string2
	call	print		; print the reversed string
	
	mov	si,string1
	mov	di,string2
	repe	cmpsb		; compare the strings (rept while eq)
	
	cmp	cx,0		; did we reach the end of the string?
	je	yes		; yes, do 
	mov 	dx,nomsg	; set up for no
	jmp	over
yes:	mov	dx,yesmsg
over:	mov	ah,9		; print string fcn
	int	21h
	
	mov	ah,4Ch		; return to DOS fcn
	mov	al,0		; normal termination
	int	21h		; BYE!
	
print:
	mov	si,dx		; set up for lodsb
	lodsb			; read first char into al
	mov	ah,2		; display char fcn
while2:	cmp	al,NULL		; is it a NULL char?
	je	endwhile2	; if so, done
	mov	dl,al		; set up for display
	int	21h		; display the char
	lodsb			; read next char
	jmp	while2		; loop until done
endwhile2:	
; print CR/LF pair
	mov	dx,CRLF
	mov	ah,9		; print string fcn
	int	21h
	ret
	
reverse:
	push	cx
	mov	si,string1	; set up source
	mov	di,string2	
	add	di,cx		; set up di to point to end of dest
	mov	byte[di],0	; mark the end of the string
	dec	di
for1:	lodsb			; copy source into al
	mov	[di],al		; store into dest
	dec	di
	loop	for1
	pop	cx
	ret
	