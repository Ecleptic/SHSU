org 100h
;EQUates section
	LF EQU 10		;line feed
	CR EQU 0Dh	;carriage return
    EOS	equ	'$'	;End of String

section .data
	prompt1	db	"Please enter the first string: ",'$'
	prompt2	db	"Please enter the second string: ",'$'
    word1	db	"The first string has a word count of ",'$'
	word2	db	"The second string has a word count of ",'$'
	echo1	db	"The first string is: ",'$'
	echo2	db	"The second string is: ",'$'
	strlen1	db	"The first string has a length of ",'$'
	strlen2	db	"The second string has a length of ",'$'

section .bss
	str1 resb	100		;reserve first string
	str2 resb	100		;reserve second string

section .text
	push str1			;push string addr onto stack
	mov ah, 9			;display str function
	mov dx, prompt1			;prepare to display msg
	int 21h				;display
	call INSTRING			;request input
	mov ah, 9			;dislpay str function
	mov dx, prompt2			;prepare to display msg
	int 21h				;display
	push str2			;save str addr
	call INSTRING			;request input

    ; length of string 1
	mov ah, 9					;display str function
	mov dx, strlen1			;prepare msg
	int 21h						;display
	push str1					;save str onto stack
	call LENGTH				;get length of str
	push ax						;save length
	call NUMOUT				;print length ofthe string

    ; length of string 2
    mov ah, 9					;display str function
	mov dx, strlen2			;prepare msg
	int 21h						;display
	push str2					;save str onto stack
	call LENGTH				;get length of str
	push ax						;save length
	call NUMOUT				;print length of the string

    ; wordcount of string1
    mov ah, 9
    mov dx, word1
    int 21h
    push str1
    call WCOUNT
    push ax
    call NUMOUT

    ; wordcount of string2
    mov ah, 9
    mov dx, word1
    int 21h
    push str2
    call WCOUNT
    push ax
    call NUMOUT


	mov ah, 9			;display str function
	mov dx, echo1			;prepare msg to display
	int 21h				;display
	push str1			;save string addr
	call PRINTLN			;print str
	mov ah, 9			;display str function
	mov dx, echo2			;prepare msg
	int 21h				;display
	push str2			;save str addr
	call PRINTLN			;print str




	jmp EXIT			;exit program

INSTRING:
		push bp				;save bp
		mov bp, sp			;make bp point to sp
		mov di, [bp + 4]		;put str addr in di
		cld				;moving forward in string
	loop:
		mov ah, 1			;read char fun
		int 21h				;read
		cmp al, 0Dh			;is cr?
		je out				;if yes, done
		stosb				;if not, store char
		jmp loop			;loop until cr
	out:
		mov al, 0			;prepare to store null char
		stosb				;store at end of string
		pop bp				;restore bp
	ret 2				;return and clear stack

PRINTLN:
		push bp				;save bp
		mov bp, sp			;make bp point to sp
		mov si, [bp + 4]		;put addr of string into si
		cld				;moving forward in string
	loop1:	lodsb				;load char into al
		cmp al, 0			;is it end of string?
		je out1				;if yes, done
		mov ah, 2			;if not, display
		mov dl, al			;prepare to display
		int 21h				;display
		jmp loop1			;loop until end
	out1:	mov ah, 2			;display line feed
		mov dl, 10
		int 21h
		pop bp				;restore bp
	ret 2				;return and clear stack

LENGTH:
	push 	bp			;save old bp
	mov	bp, sp			;make bp point to top of stack
	xor	cx, cx			;clear cx
	mov	si, [bp + 4]		;initialize di with string address
	cld				;going forward in string
loop2:
	lodsb				;load into al
	cmp	al, 0			;is end of string?
	je	out2			;if it is, we are done scanning
	inc	cx			;if not, character count incremented
	jmp 	loop2			;loop until end of string
out2:
	mov	ax, cx			;character count to be returned in ax
	pop	bp
	ret	2			;return and clear stack

NUMOUT:
		push	bp
		mov	bp, sp		;make bp stack pointer
		mov	bx, [bp + 4]	;address of number in bx
		mov	ax, bx	;move contents of address at bx into ax
		mov	dx, 0		;clear data reg
		mov	cx, 0		;clear counter
		mov 	bx, 0		;clear bx to store quotient
	top2:	mov	dl, 10		;prepare to divide ax by 10
		div	dl		;divide ax by 10
		mov	bl, al		;store quotient in bl
		add	ah, '0'		;convert remainder to ASCII
		mov	dl, ah		;prepare to push
		push	dx		;save digit
		inc	cx		;increment counter
		mov	ax, bx		;move quotient to ax to be divided again
		cmp	ax, 0		;see if we are done dividing
		ja	top2		;if not, loop to top
	print:	pop 	dx		;prepare to print digit
		mov	ah, 2		;display char function
		int 	21h		;display
		loop	print		;loop until done
		mov	ah, 2		;display char fun
		mov	dl, LF		;lf when done printing
		int	21h		;display
		pop	bp
	ret	2		;clear stack and return

WCOUNT:
		push bp							;save old bp
		mov bp, sp					;point bp to top of stack
		push cx							; save count
		xor cx, cx					;clear count (cx)
		mov ax, ds					;init es
		mov es, ax
		mov word di, [bp+4]	;init di with string address
		cld							;move forward in string
    loop3:
        mov al, 0       ;is it the end of the string?
        scasb           ;compare strings
        je out3         ;is it a 0 (end of string)? exit
        dec di          ;otherwise is it a space
        mov al, ' '     ; cmp space
        scasb           ; is it a space?
        jne loop3       ; if not, keep going
        inc cx          ; if it's a space add 1 to word count
        jmp    loop3    ; loop until 0
    out3:
        inc cx          ; last word count
        mov ax, cx      ; count goes to ax
        pop cx          ; restore count
        pop bp          ;
        ret 2           ; return and clear stack

EXIT:
	mov ah, 04Ch
	mov al, 0
	int 21h
