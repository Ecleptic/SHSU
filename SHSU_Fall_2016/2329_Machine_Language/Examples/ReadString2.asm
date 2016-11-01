org 100h
section	.bss
input	resb 	80

section	.text
mov	di,input
cld                     ;process from left
xor     bx,bx           ;BX holds no. of chars read
mov     ah,1            ;input char function
int     21h             ;read a char into AL

WHILE1:
  cmp     al,0Dh          ;<CR>?
  je      ENDWHLE1	       ;yes, exit
;if char is backspace
  cmp     al,08h          ;is char a backspace?
  jne     ELSE1           ;no, store in string
  dec     di              ;yes, move string ptr back
  dec     bx              ;decrement char counter
  jmp     READ            ;and go to read another char
ELSE1:
  stosb                   ;store char in string
  inc     bx              ;increment char count
READ:
  int     21h             ;read a char into AL
  jmp     WHILE1          ;and continue loop
ENDWHLE1:
  mov byte [di], '$'
  mov ah,9
  mov dx, input
  int 21h
  mov	ax,4C00h
  int 21h
