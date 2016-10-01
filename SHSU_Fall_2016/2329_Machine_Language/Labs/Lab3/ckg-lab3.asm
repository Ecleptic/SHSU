org	100h

section .data
prompt1: db	"Please enter a letter: $"
prompt2: db "This was not a letter, please type in a letter and try again. $"
prompt3: db "As an 8-bit binary value the letter looks like this: $"
prompt4: db "In upper case the letter looks like this: $"
prompt5: db "In lower case the letter looks like this: $"
prompt6: db "Would you like to repeat this?  (Y/N)$"

section .text
start:
  mov	ah,9		; print prompt
  mov	dx,prompt1
  int 21h

  call letter_in  ;read a letter

  mov ah,9
  mov dx,prompt2
  int 21h



  Exit:
  	mov     ah,04Ch           ;DOS function: Exit program
  	mov     al,0              ;Return exit code value
  	int     21h               ;Call DOS.  Terminate program

wrong:
mov	ah,9		; print prompt
mov	dx,prompt1
int 21h
jmp begin

letter_in:
  push ax
  mov bx,0
begin:
  mov	ah,9		; print prompt
  mov	dx,prompt1
  int 21h
  mov	ah,1		; input char function
	int	21h		; read char into al
isletter:
  and al,0DFh ;Force uppercase letter (if letter)
  cmp al, "A"
  jl wrong
  cmp al,"Z"
  jg wrong
top1:
  mov ah,9
  mov dx,al
  int 21h
out1:
  pop	ax		; restore reg
	ret			; return with input value in bx
