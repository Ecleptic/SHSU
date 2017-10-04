	org	100h
;set DS to active display page             
        mov     ax,0B800h  ;color active display page
        mov     es,ax       
        mov     cx,2000    ;80*25 = 2000 words
        mov     di,0       ;initialize DI
        mov     ax,1E41h   ;yellow A on blue
;fill active display page

        rep stosw
    
	
	mov	ax,4C00h
	int	21h
	