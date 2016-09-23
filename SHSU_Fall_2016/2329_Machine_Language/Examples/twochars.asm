        cpu 8086
        org 100h
ASCIIcr EQU     0Dh 
ASCIIlf EQU     0Ah
section .data 
        ; put data items here 
msg:    db      "Enter a character: ",'$'
msg2:   db      ASCIIcr, ASCIIlf, "The 'larger' character is: $"
section .bss 

        ; put uninitialised data here
section .text 

start: 
        ; put your code here 
; display prompt
	mov	dx,msg        ; get message1
        mov     ah, 09h       ; display string function 
        int     21h           ; display it 
; input a character 
        mov     ah, 01h       ; read character function 
        int     21h           ; character in AL 
        push    ax            ; save it on stack
; go to a new line 
        mov     ah, 02h       ; display character function 
        mov     dl, ASCIIcr   ; carriage return 
        int     21h           ; execute carriage return 
        mov     dl, ASCIIlf   ; line feed 
        int     21h           ; execute line feed
; display prompt
	mov	dx,msg        ; get message1
        mov     ah, 09h       ; display string function 
        int     21h           ; display it 
; input a character 
        mov     ah, 01h       ; read character function 
        int     21h           ; character in AL 
        push    ax            ; save it on stack
; display output prompt on a new line 
        mov     ah, 09h       ; display string function 
        mov     dx, msg2      ; address of string in dx 
        int     21h

        call    first         ; al has "smaller" character
        


; display character 
        mov     dl, al        ; retrieve input character from al
        mov     ah, 2         ; display char fcn       
        int     21h           ; and display it 
; return to DOS 
	mov	ah, 4Ch	      ; DOS ret system call
	mov	al, 0	      ; normal termination code
	int	21h

first:
        push    bp              ; save old bp
        mov     bp,sp           ;
        mov     ax,[bp+6]       ; load first char entered
        cmp     ax,[bp+4]       ; compare 2nd char
        ja      done            ; first char larger
        mov     ax,[bp+4]       ; 2nd char larger
done:   pop     bp
        ret     4
	

