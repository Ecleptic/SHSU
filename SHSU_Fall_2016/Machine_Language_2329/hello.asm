; HelloWorld in NASM assembly
;    *  to assemble, use the command "nasm -fbin hello.asm -o hello.com"
;    *  to execute, type ".\hello.com"

	org 100h
	
section .text
	
start:
	mov dx,msg
	mov ah, 9
	int 21h
	
	mov ah, 4Ch
	mov al, 0
	int 21h
	
section .data
msg:	db  "Hello, world!", 0Dh, 0Ah, '$'

; Hello there! 
