	org 100h
Start:  
;set video mode
	mov     ah,0              ;select mode function
	mov     al,3              ;80x25 color text
	int     10h               ;select mode
;clear window to red
	mov     ah,6              ;scroll up function
	mov     cx,081Ah          ;upper left corner (1Ah,08h) (26,8)
	mov     dx,1034h          ;lower right corner (34h,10h)(52,16)
	mov     bh,43h            ;cyan chars on red background
	mov     al,0              ;scroll all lines
	int     10h               ;clear window\;move cursor
	mov     ah,2              ;move cursor function
	mov     dx,0C27h          ;center of screen (27h,0Ch) (39,12)
	xor     bh,bh             ;page 0
	int     10h               ;move cursor
;display character with attribute
	mov     ah,09             ;display character function
	mov     bh,0              ;page 0
	mov     bl,0C3h           ;blinking cyan char, red background
	mov     cx,1              ;display one character
	mov     al,'A'            ;character is 'A'
	int     10h               ;display character
;return to DOS
Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program
