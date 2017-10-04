org 100h
;equates section
	LF EQU 10		            ;line feed
	CR EQU 0Dh	                ;carriage return
    EOS	equ	'$'	                ;End of String

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
	str1 resb	100		        ;reserve first string
	str2 resb	100		        ;reserve second string

section .text
	push str1			        ;push string addr onto stack
	mov ah, 9			        ;display str function
	mov dx, prompt1			    ;prepare to display msg
	int 21h				        ;display
	call INSTRING			    ;request input
	mov ah, 9			        ;dislpay str function
	mov dx, prompt2			    ;prepare to display msg
	int 21h				        ;display
	push str2			        ;save str addr
	call INSTRING			    ;request input

    ; length of string 1
	mov ah, 9					;display str function
	mov dx, strlen1			    ;prepare msg
	int 21h						;display
	push str1					;save str onto stack
	call LENGTH				    ;get length of str
	push ax						;save length
	call NUMOUT				    ;print length ofthe string

    ; length of string 2
    mov ah, 9					;display str function
	mov dx, strlen2			    ;prepare msg
	int 21h						;display
	push str2					;save str onto stack
	call LENGTH				    ;get length of str
	push ax						;save length
	call NUMOUT				    ;print length of the string

    ; wordcount of string1
    mov ah, 9          			;display str function
    mov dx, word1			    ;prepare msg
    int 21h						;display
    push str1					;save str1 onto stack
    call WCOUNT                 ;get the word count
    push ax                     ;save wordcount
    call NUMOUT                 ;print the number of wordcount

    ; wordcount of string2
    mov ah, 9          			;display str function
    mov dx, word2			    ;prepare msg
    int 21h						;display
    push str2					;save str2 onto stack
    call WCOUNT                 ;get the word count
    push ax                     ;save wordcount
    call NUMOUT                 ;print the number of wordcount


	mov ah, 9			        ;display str function
	mov dx, echo1			    ;prepare msg to display
	int 21h				        ;display
	push str1			        ;save string addr
	call PRINTLN			    ;print str
	mov ah, 9			        ;display str function
	mov dx, echo2			    ;prepare msg
	int 21h				        ;display
	push str2			        ;save str addr
	call PRINTLN			    ;print str
	jmp EXIT			        ;jump to exit

INSTRING:
		push bp				    ;save bp
		mov bp, sp			    ;make bp point to sp
		mov di, [bp + 4]		;put str addr in di
		cld				        ;moving forward in string
	strLoop:
		mov ah, 1			    ;read char fun
		int 21h				    ;read
		cmp al, 0Dh			    ;is cr?
		je strOut				    ;if yes, done
		stosb				    ;if not, store char
		jmp strLoop			    ;loop until cr
	strOut:
		mov al, 0			    ;prepare to store null char
		stosb				    ;store at end of string
		pop bp				    ;restore bp
	ret 2				        ;return and clear stack

PRINTLN:
		push bp				    ;save bp
		mov bp, sp			    ;make bp point to sp
		mov si, [bp + 4]		;put addr of string into si
		cld				        ;moving forward in string
	printLoop:	lodsb				;load char into al
		cmp al, 0			    ;is it end of string?
		je printOut				    ;if yes, done
		mov ah, 2			    ;if not, display
		mov dl, al			    ;prepare to display
		int 21h				    ;display
		jmp printLoop			    ;loop until end
	printOut:	mov ah, 2			;display line feed
		mov dl, 10
		int 21h
		pop bp				    ;restore bp
	ret 2				        ;return and clear stack

LENGTH:
	push 	bp			        ;save old bp
	mov	bp, sp			        ;make bp point to top of stack
	xor	cx, cx			        ;clear cx
	mov	si, [bp + 4]		    ;initialize di with string address
	cld				            ;going forward in string
lenLoop:
	lodsb				        ;load into al
	cmp	al, 0			        ;is end of string?
	je	lenOut			        ;if it is, we are done scanning
	inc	cx			            ;if not, character count incremented
	jmp 	lenLoop			    ;loop until end of string
lenOut:
	mov	ax, cx			        ;character count to be returned in ax
	pop	bp
	ret	2			            ;return and clear stack

NUMOUT:
		push	bp
		mov	bp, sp		        ;make bp stack pointer
		mov	bx, [bp + 4]	    ;address of number in bx
		mov	ax, bx	            ;move contents of address at bx into ax
		mov	dx, 0		        ;clear data reg
		mov	cx, 0		        ;clear counter
		mov 	bx, 0		    ;clear bx to store quotient
	numTop:	mov	dl, 10		    ;prepare to divide ax by 10
		div	dl		            ;divide ax by 10
		mov	bl, al		        ;store quotient in bl
		add	ah, '0'		        ;convert remainder to ASCII
		mov	dl, ah		        ;prepare to push
		push	dx	            ;save digit
		inc	cx		            ;increment counter
		mov	ax, bx		        ;move quotient to ax to be divided again
		cmp	ax, 0		        ;see if we are done dividing
		ja	numTop		        ;if not, loop to top
	numPrint:	pop 	dx		;prepare to print digit
		mov	ah, 2		        ;display char function
		int 	21h		        ;display
		loop	numPrint		;loop until done
		mov	ah, 2		        ;display char fun
		mov	dl, LF		        ;lf when done printing
		int	21h		            ;display
		pop	bp
	ret	2		                ;clear stack and return

WCOUNT:
		push bp					;save old bp
		mov bp, sp				;point bp to top of stack
		push cx					;save count
		xor cx, cx				;clear count (cx)
		mov ax, ds				;init es
		mov es, ax
		mov word di, [bp+4]	    ;init di with string address
		cld						;move forward in string
    wordLoop:
        mov al, 0               ;is it the end of the string?
        scasb                   ;compare strings
        je wordOut              ;is it a 0 (end of string)? exit
        dec di                  ;otherwise is it a space
        mov al, ' '             ;cmp space
        scasb                   ;is it a space?
        jne wordLoop            ;if not, keep going
        inc cx                  ;if it's a space add 1 to word count
        jmp    wordLoop         ;loop until 0
    wordOut:
        inc cx                  ;last word count
        mov ax, cx              ;count goes to ax
        pop cx                  ;restore count
        pop bp                  ;
        ret 2                   ;return and clear stack

EXIT:
	mov ah, 04Ch                ;exit BECAUSE WE'RE DONE!
	mov al, 0
	int 21h
