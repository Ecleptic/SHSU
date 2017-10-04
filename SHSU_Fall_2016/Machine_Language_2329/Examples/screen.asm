; writing data to screen using int 10h BIOS routines

	org 100h		; start program at offset 100h, leaving room for PSP
	
section .text			; "text" refers to program instructions
	
start:

        mov     ah,0            ; set mode to mode 3 (80x25 color text)
        mov     al,3
        int     10h

        mov     ah,2            ; move cursor to row 12, col 39
        xor     bh,bh           ;page 0
        mov     dx,0C27h        ;row = 12, column = 39
        int     10h             ;move cursor

        mov     ah,9
        mov     bh,0
        mov     bl,3Ch
        mov     al,'A'
        mov     cx,1
        int     10h
                

        mov     ah,4Ch
        mov     al, 0
        int     21h
