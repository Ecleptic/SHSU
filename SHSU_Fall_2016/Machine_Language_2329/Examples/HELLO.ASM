	org	100h
;----- EQUates section 
ASCIIcr EQU     0Dh 
ASCIIlf EQU     0Ah

;----- Data section
section .data
msg     DB      "Hello, World!", ASCIIcr, ASCIIlf, '$'

;----- Code section
section .text

main: 	
; display message
        mov     dx, msg       ; get message1
        mov     ah, 09h       ; display string function 
        int     21h           ; display it 

; return to DOS
Exit: 
        mov     ah, 04Ch      ; DOS function: Exit program 
        mov     al, 0         ; Return exit code value 
        int     21h           ; Call DOS. Terminate program 


