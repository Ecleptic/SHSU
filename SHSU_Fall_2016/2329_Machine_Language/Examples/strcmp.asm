	org	100h
section	.data
str1	db	"abcdefghijklmnop"
str2	db	"abcdxyz123456789"
lower	db	"lower",13,10,'$'
higher	db	"higher",13,10,'$'

section	.text
	mov	si, str1
	mov	di, str2
	cld			;left to right 
				;     processing
	mov	cx,16		;shorter string
	repe	cmpsb		;cmp til <> or cx=0
	jb		str1smaller
	ja		str2smaller
;the strings are equal - so far
;if sizes different, shorter string is less
str1smaller:
	mov 	dx,lower
	jmp	display
str2smaller:
	mov	dx,higher
display:
	mov	ah,9
	int 	21h
	
	mov	ax,4C00h
	int	21h