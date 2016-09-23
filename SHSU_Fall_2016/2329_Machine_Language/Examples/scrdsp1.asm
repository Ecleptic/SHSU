	org	100h
section .txt	
start:  
;set video mode
	mov     ah,0              ;select mode function
	mov     al,3              ;80x25 color text
	int     10h               ;select mode

	mov     ah,2              ;move cursor function
	mov     dx,0C27h          ;center of screen (27h,0Ch) (39,12)
	xor     bh,bh             ;page 0
	int     10h               ;move cursor
	
	mov	ah,6
	mov	al,0
	mov	ch,8
	mov	cl,24
	mov	dh,16
	mov	dl,48
	mov	bh,41h
	int	10h
	
;display character with attribute
        mov     ah,09             ;display character function
        mov     bh,0              ;page 0
        mov     bl,0C3h           ;blinking cyan char, red background
        mov     cx,1              ;display one character
        mov     al,'A'            ;character is 'A'
        int     10h               ;display characte
;
	mov     ah,2              ;move cursor function
        mov     dx,1700h          ;bottom of screen (27h,0Ch) (39,12)
	xor     bh,bh             ;page 0
	int     10h               ;move cursor

Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program
