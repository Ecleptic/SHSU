        org 100h
section .text
Start: 
;set video mode and clear screen
	mov     AH,0            ;set mode function
	mov     AL,3            ;80x25 color text
	int     10h             ;set mode
;move cursor to upper left corner
	mov     AH,2            ;move cursor function
	xor     DX,DX           ;position (0,0)
	mov     BH,0            ;page 0
	int     10h             ;move cursor
;get keystroke
	mov     AH,0            ;keyboard input function
	int     16h             ;AH=scan code,AL=ascii code
WHILE_:
	cmp     AL,1Bh          ;ESC (exit character)?
	je      END_WHILE       ;yes, exit
;if function key
	cmp     AL,0            ;AL = 0?
	jne     ELSE_           ;no, character key
;then
	call    DO_FUNCTION     ;execute function
	jmp     NEXT_KEY        ;get next keystroke
ELSE_:                         
;display character
	mov     AH,2            ;display character func
	mov     DL,AL           ;GET CHARACTER
	int     21h             ;display character
NEXT_KEY:
	mov     AH,0            ;get keystroke function
	int     16h             ;AH=scan code,AL=ASCII code
	jmp     WHILE_
END_WHILE:
;DOS exit
	mov     AH,4Ch
	int     21h


DO_FUNCTION:
; operates the arrow keys
; input: AH scan code
; output: none 
	push    BX
	push    CX
	push    DX
	push    AX              ;save scan code
;locate cursor
	mov     AH,3            ;get cursor location
	mov     BH,0            ;on page 0
	int     10h             ;DH = row, DL = col
	pop     AX              ;retrieve scan code
;case scan code of
	cmp     AH,72           ;up arrow?
	je      CURSOR_UP       ;yes, execute
	cmp     AH,75           ;left arrow?
	je      CURSOR_LEFT     ;yes, execute
	cmp     AH,77           ;right arrow?
	je      CURSOR_RIGHT    ;yes, execute
	cmp     AH,80           ;down arrow?
	je      CURSOR_DOWN     ;yes, execute
	jmp     EXIT            ;other function key
CURSOR_UP:
	cmp     DH,0            ;row 0?
	je      SCROLL_DOWN     ;yes, scroll down
	dec     DH              ;no, row = row - 1
	jmp     EXECUTE         ;go to execute
CURSOR_DOWN:
	cmp     DH,24           ;last row?
	je      SCROLL_UP       ;yes, scroll up
	inc     DH              ;no, row = row + 1
	jmp     EXECUTE         ;go to execute
CURSOR_LEFT:
	cmp     DL,0            ;column 0?
	jne     GO_LEFT         ;no, move to left
	cmp     DH,0            ;row 0?
	je      SCROLL_DOWN     ;yes, scroll down
	dec     DH              ;row = row - 1
	mov     DL,79           ;last column 
	jmp     EXECUTE         ;go to execute
CURSOR_RIGHT:
	cmp     DL,79           ;last column?
	jne     GO_RIGHT        ;no, move to right
	cmp     DH,24           ;last row?
	je      SCROLL_UP       ;yes, scroll up
	inc     DH              ;row = row + 1
	mov     DL,0            ;col = 0
	jmp     EXECUTE         ;go to execute
GO_LEFT:
	dec     DL              ;col = col - 1
	jmp     EXECUTE         ;go to execute
GO_RIGHT:
	inc     DL              ;col = col + 1
	jmp     EXECUTE         ;go to execute
SCROLL_DOWN:
	mov     AL,1            ;scroll 1 line
	xor     CX,CX           ;upper left corner = (0,0)
	mov     DH,24           ;last row
	mov     DL,79           ;last column
	mov     BH,07           ;normal attribute
	mov     AH,7            ;scroll down function
	int     10h             ;scroll down 1 line
	jmp     EXIT            ;exit procedure
SCROLL_UP:
	mov     AL,1            ;scroll up 1 line
	xor     CX,CX           ;upper left corner = (0,0)
	mov     DX,184Fh        ;lower right corner = (4Fh,18h)
	mov     BH,07           ;normal attribute
	mov     AH,6            ;scroll up function
	int     10h             ;scroll up
	jmp     EXIT            ;exit procedure
EXECUTE:
	mov     AH,2            ;cursor move function
	int     10h             ;move cursor
EXIT:
	pop     DX
	pop     CX
	pop     BX
	ret



