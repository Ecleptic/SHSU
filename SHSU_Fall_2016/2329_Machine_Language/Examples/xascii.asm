	org	100h
	section .text	
        mov     ah, 02h         ; display character function
        mov     cx,256          ; no. of chars to display
        mov     dl, 0           ; dl has ASCII code of null char
Ploop:  int     21h             ; display a character
        inc     dl              ; increment ASCII code
        dec     cx              ; decrement counter
        jnz     Ploop      	  ; keep going if cx not zero
Exit:   mov     ah, 04Ch        ; DOS function: Exit program
        mov     al, 0           ; Return exit code value
        int     21h             ; Call DOS.  Terminate program
