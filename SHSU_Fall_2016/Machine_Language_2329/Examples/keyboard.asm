	org 100h
	mov     ah,0              	;read keystroke function
	int     16h			;al = ASCII code or 0,
					;ah = scan code
	or      al,al          	;al = 0? (function key?)
	jne     Exit             	;no, character key
	cmp     ah,3Bh             	;scan code for F1?
	je      F1			;yes, go to move cursor
;other function key
	mov     dx,184Fh           	;lower right corner (4Fh,18h)
	jmp     Execute            	;go to move cursor
F1:
	xor     dx,dx           	;upper left corner
Execute:
	mov     ah,2              	;move cursor function
	xor     bh,bh            	;page
	int     10h               	;move cursor
;return to DOS
Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program
