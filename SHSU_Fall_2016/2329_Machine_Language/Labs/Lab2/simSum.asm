org 100h

section .data
char resb 1

section .text
; print a prompt
mov   ah,2                    ;display character function
mov   dl,'?'                  ;? prompt
int   21h                     ;do it

; read a char from keyboard
mov   ah,1                    ;read char function
int   21h                     ;read it into al (don't know how)
; Carriage return?
mov   dl, 10
mov   ah, 02h
int   21h
mov   dl, 13
mov   ah, 02h
int   21h




; say goodbye
mov     ah,4Ch
mov     al,0
int     21h
