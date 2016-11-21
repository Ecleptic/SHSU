; program that displays the current time
; and updates the time 18.2 times per second
;
	org 100h
	section	.data

TIME_BUF        DB      '00:00:00$'     ; time buffer hr:min:sec
CURSOR_POS      DW      0               ; cursor position (row:col)
NEW_VEC         DW      0,0             ; new interrupt vector
OLD_VEC         DW      0,0             ; old interrupt vector
;


	section .text
Start:
; save cursor position
	mov     ah,3            ; function 3, get cursor
	mov     bh,0            ; page 0
	int     10h             ; dh = row, dl = col
	mov     [CURSOR_POS],dx ; save it
; set up interrupt procedure by placing
;   segment:offset of TIME_INT in NEW_VEC
	mov     word [NEW_VEC],TIME_INT       ; offset
	mov     [NEW_VEC+2],ds           ; segment
	lea     di,[OLD_VEC]    ; di points to vector buffer
	lea     si,[NEW_VEC]    ; si points to the new vector
	mov     al,1Ch          ; timer interrupt
	call    SETUP_INT       ; set up new interrupt vector
; read keyboard
	mov     ah,0
	int     16h
; restore old interrupt vector
	lea     si,[OLD_VEC]    ; di points to vector buffer
	lea     di,[NEW_VEC]    ; si points to the new vector
	mov     al,1Ch          ; timer interrupt
	call    SETUP_INT       ; set up new interrupt vector

;exit
	mov     ah,4Ch          ; return
	int     21h             ;  to DOS


TIME_INT:
; interrupt procedure
; activated by the timer
; get and display time
	lea     bx,[TIME_BUF]   ; bx points to TIME_BUF
	call    GET_TIME        ; put current time in TIME_BUF
	lea     dx,[TIME_BUF]   ; dx points  to TIME_BUF
	mov     ah,09h          ; display time
	int     21h
; restore cursor position
	mov     ah,2            ; function 2, move cursor
	mov     bh,0            ; page 0
	mov     dx,[CURSOR_POS] ; cursor position, dh = row, dl = col
	int     10h             ; perform function
	iret										; iret is used because this wasn't called. it was implicit.
				; end of interrupt routine

SETUP_INT:
; saves old vector and sets up new vector
; input:        AL = interrupt number
;               DI = address of buffer for old vector
;               SI = address of buffer containing new vector
; save old interrupt vector
        mov     ah,35h          ; function 35h, get interrupt vector
        int     21h             ; es:bx = vector
        mov     [di],bx         ; save offset
        mov     [di+2],es       ; save segment
; setup new vector
        mov     dx,[si]         ; dx has offset
        push    ds              ; save ds
        mov     ds,[si+2]       ; ds has segment number
        mov     ah,25h          ; function 25h, set vector
        int     21h             ;   set it
        pop     ds              ; restore ds
        ret

; procedure GET_TIME
;get time of day and store ASCII digits in time buffer
;input:  BX = address of time buffer
GET_TIME:
	mov     AH,2Ch          ;gettime
	int     21h             ;CH = hr, CL =  min, DH = sec
;convert hours into ASCII and store
	mov     AL,CH           ;hour
	call    CONVERT         ;convert to ASCII
	mov     [BX],AX         ;store
;convert minutes into ASCII and store
	mov     AL,CL           ;minute
	call    CONVERT         ;convert to ASCII
	mov     [BX+3],AX       ;store
;convert seconds into ASCII and store
	mov     AL,DH           ;second
	call    CONVERT         ;convert to ASCII
	mov     [BX+6],AX       ;store
	ret


; procedure CONVERT
;converts byte number (0-59) into ASCII digits
;input:  AL = number
;output: AX = ASCII digits, AL = high digit, AH = low digit
CONVERT:
	mov     AH,0            ;clear AH
	mov     DL,10           ;divide AX by 10
	div     DL              ;AH has remainder, AL has quotient
	or      AX,3030h        ;convert to ASCII, AH has low digit
	ret
