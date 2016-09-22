org 100h

section .data
prompt      DB      "?","$"
crlf        DB      13,10,'$'                                   ;carriage return and line feed?
NUM1:       DB      0,"$"
NUM1Ascii:  DB      0,"$"
NUM2:       DB      0,"$"
NUM2Ascii:  DB      0,"$"
prompt1:    DB      "The Sum of ","$"
prompt2:    DB      " and ","$"
prompt3:    DB      " is ","$"

section .text
; print a prompt
mov ah,09h                         ; display string function
mov dx,prompt                      ; dx has the address of string
int 21h                            ; displays the prompt
; get the num1 from the user
mov     ah,01h                     ; read char fcn
int     21h                        ; input char into AL
mov     [NUM1Ascii],al
sub     al,30h                     ; convert to number
mov     [NUM1],al                  ; and store it
; get num 2
mov     ah,01h                     ; read char fcn
int     21h                        ; input char into AL
mov     [NUM2Ascii],al
sub     al,30h                     ; convert to number
mov     [NUM2],al                  ; and store it
; Carriage Return
mov     dx, crlf                   ; carriage return line feed
mov     ah,9                      ; display string function
int     21h
; Start answer
mov      ah,9
mov      dx,prompt1                ; "The sum of"
int      21h
; print NUM1 in ascii
mov    ah,9
mov    dx,NUM1Ascii                ; first number in ascii
int    21h
; string #2
mov ah,9
mov dx, prompt2                    ; " and "
int 21h
; print NUM2 in ascii
mov    ah,9
mov    dx,NUM2Ascii                ; second number in ascii
int    21h
; string #2
mov ah,9
mov dx, prompt3                    ; " is "
int 21h
;Add the numbers
mov al,[NUM2]                      ; save NUM2
add al, [NUM1]                     ; add NUM1 to NUM2 and save to NUM2
add al,30h                         ; add 30 hex back to NUM2 for the ascii key
mov [NUM1],al                      ; finally get it ready to print
;Display NUM1 post math
mov ah,9
mov dx,NUM1
int 21h
; exit to DOS
mov ah, 4Ch     ; DOS exit function
mov al,0h       ; normal termination
int 21h         ; we're done here
