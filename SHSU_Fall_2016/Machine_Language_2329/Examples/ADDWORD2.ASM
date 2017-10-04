; Program ADDWORDS, version 2
; original program with output
	org 100h		; origination point for .COM format files
section .data
WORD1   DW      6
WORD2   DW      5

section .text
MAIN:
        push    word [WORD1]	; prepare to add two words
        push    word [WORD2]
        call    ADD_WORDS	; add the two words, return sum in ax
	mov	bx,ax		; set up for call to print result
	call	HEX_OUT		; print result in base 16
        mov     ah,4Ch		; exit to DOS
        int     21h

ADD_WORDS:       
;adds two memory words
;stack on entry: return addr.(top), word2, word1
;output: ax = sum
       push    bp              ;save bp
       mov     bp,sp
       mov     ax,[bp+6]       ;ax gets WORD1
       add     ax,[bp+4]       ;ax has sum
       pop     bp              ;restore bp
       ret     4               ;return and clean up stack


HEX_OUT:
; prints value in BX register
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
	pop	dx		; restore registers
	pop	cx
	pop	ax
	ret			; go back to where you came from
	