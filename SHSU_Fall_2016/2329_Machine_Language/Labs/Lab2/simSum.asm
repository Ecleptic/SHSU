org 100h

section .data
prompt  db      "?","$"
crlf    db      13,10,'$'                                     ;carriage return and line feed in decimal
; crlfhx  db      0Dh,0Ah,'$'                                 ;carriage return and line feed in hex
NUM1:    DB      0,"$"
NUM2:    DB      0,"$"

section .text
; print a prompt
mov ah,09h                         ; display string function
mov dx,prompt                      ; dx has the address of string
int 21h                            ; displays the prompt

; get the num from the user
mov     ah,01h                     ; read char fcn
int     21h                        ; input char into AL
sub     al,30h                      ; convert to number
mov     [NUM1],al                  ;  and store it
; get num 2
mov     ah,01h                     ; read char fcn
int     21h                        ; input char into AL
sub     al,30h                     ; convert to number
mov     [NUM2],al                  ;  and store it
; Carriage Return
mov     dx, crlf                   ; get second message
 mov     ah,9                      ; display string function
 int     21h
;Add the numbers
 mov al,[NUM2]                      ; save NUM2
 add al, [NUM1]                     ; add NUM1 to NUM2 and save to NUM1
 add al,30h                         ; add 30 hex back to NUM1 for the ascii key
 mov [NUM1],al                      ; finally get it ready to print
;Display NUM1 post math
mov ah,9
mov dx,NUM1
int 21h


; exit to DOS
mov ah, 4Ch     ; DOS exit function
mov al,0h       ; normal termination
int 21h         ; we're done here
