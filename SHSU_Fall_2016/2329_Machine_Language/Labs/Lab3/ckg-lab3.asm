; Cameron Green 8/7/16
; Purpose: Input a letter and print it in uppercase,lowercase and 8-bit binary

org	100h

section .data
upper: db '' ,'$'
CR: db  0Dh,0Ah ,'$'
prompt1: db 'Enter a letter: $'
prompt2: db "This was not a letter, please type in a letter and try again. ","$"
RAW: db '' ,'$'
prompt3: db "In 8-bit bin the letter looks like this: ","$"
prompt4: db "In uppercase the letter looks like this: ","$"
prompt5: db "In lowercase the letter looks like this: ","$"
prompt6: db "Would you like to repeat this?  (Y/N): ","$"
lower: db '','$'
exCode: db 0,"$"

section .text
start:

  call letter_in  ;read a letter

  call letter_out ;print the letter in upper and lower case

again?:
  mov	dx,CR
  mov	ah,09h 		; CR
  int 21h
  mov	dx,CR
  mov	ah,09h 		; CR
  int 21h

  mov	dx,prompt6
  mov	ah,09h 		; repeat?
  int 21h

  mov bx,0		; bx holds input value
  mov	ah,1		; input char function
  int	21h		  ; read char into al
  and al,0DFh ; Force uppercase letter (if letter)
  cmp al, "Y" ; if it's 'Y' then restart

  mov	dx,CR
  mov	ah,09h 		; CR
  int 21h
  mov	dx,CR
  mov	ah,09h 		; CR
  int 21h

  ; CR for spacing. looks nice and it doesn't matter really if there are spaces when the program exits. (it looks nicer that way anyways.)

  je start    ;if it is 'Y' then restart

Exit:
	mov     ah,04Ch           ;DOS function: Exit program
	mov     al,0              ;Return exit code value
	int     21h               ;Call DOS.  Terminate program


letter_in:
  push ax
begin:
  mov	dx,prompt1
  mov	ah,09h 		; print prompt
  int 21h

  mov	ah,1		; input char function
	int	21h		  ; read char into al


  mov [RAW],al        ;save the input
  mov al,[RAW]

  and al,0DFh ; Force uppercase letter (if letter)
  cmp al, "A"
  jl wrong
  cmp al,"Z"
  jg wrong    ; if it's not between 'A'-'Z' then repeat until the user makes it 'A'-'Z'

  call conBin

  mov	dx,CR
  mov	ah,09h 		; Enter
  int 21h

  mov [upper],al    ; save the uppercase letter into upper



out1:
  pop	ax		; restore reg
ret

wrong:
  mov	dx,CR
  mov	ah,09h 		; Enter
  int 21h

  mov	dx,prompt2
  mov	ah,09h 		; print prompt
  int 21h
  jmp begin
ret

letter_out:
  mov	ah,09h 		; "in uppercase it's":
  mov	dx,prompt4
  int 21h

  mov ah,09h
  mov dx,upper
  int 21h

  mov al,[upper]    ; pull upper back into al
  add al,020h       ; convert to lowercase
  mov [lower],al    ; save the lowerase letter into lower

  mov	ah,09h 		; "in lowercase it's":
  mov	dx,prompt5
  int 21h

  mov ah,09h
  mov dx,lower
  int 21h
ret

conBin:   ;convert binary
; Save the registers for later restoration
  push ax
  push bx
  push cx

  mov al,[RAW]
  mov	dx,CR
  mov	ah,09h 		; CR
  int 21h

  mov	dx,prompt3
  mov	ah,09h 		   ; Binary is:
  int 21h
  mov al, [RAW]    ; Load number in al
  mov cx, 08H     ; cx is going to be 8 (8 times)
  mov ah, 00h      ; ah=00
binloop:
  shl al, 01h      ; divide the number by 2
  mov bl, al       ; setup display
  mov al, 0H       ; take the lowest bit
  adc al, 30h
  mov dl, al
  mov ah, 02h
  int 21h           ; display the number
  mov al, bl
  dec cx            ; subtract by 1
  jnz binloop       ;loop until all 8 digits are finished.

  ; Restore the registers
  pop cx
  pop bx
  pop ax
ret
