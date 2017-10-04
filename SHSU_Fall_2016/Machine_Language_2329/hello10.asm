; TITLE "First Program -- HELLO.asm"
org 100h
section.data
msg DB "Hello World!$"
section .text
Start:
mov dx,msg ;get message
mov ah,09h ;display string function
int 21h; interrupt function 21 hex display message
Exit: mov ah,4ch ;DOS Function: exit program
mov al,0 ;return exit code value
int 21h ;call dos. terminate program
