	org	100h
section .text	
start:  
;set DS to active display page             
        mov     ax,0B800h  ;color active display page
        mov     ds,ax       
        mov     cx,2000    ;80*25 = 2000 words
        mov     di,0       ;initialize DI
        mov     ax,1E41h   ;yellow A on blue
;fill active display page
fillbuf:
        mov     [di],ax    ;char in al, attribute in ah
        add     di, 2      ;go to next word
        loop    fillbuf    ;loop until done

;return to DOS
Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program
