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


; The following method can be used to generate random numbers in the range 1 to 32767:
;
; Start with any number in this range.
; Shift left by one bit
; Replace bit 0 by the XOR of bits 14 and 15
; Clear bit 15
;
; You are to write a program with the following subprograms:
;
; A procedure READ that lets the user enter a base 10 integer from the keyboard and returns it value in AX.
; A procedure WRITE that receives a number in AX and displays that number as a base 10 integer.
; A procedure RANDOM that receives a number in AX and returns the next random number in the AX register.
; Write a program using these procedures that displays a prompt, calls READ to read a base 10 value, and calls RANDOM and WRITE to compute and display 20 random numbers, one number per line. All of your procedures should save and restore any registers they use (other than AX when it is used as a return value, of course.)
;
; Your program should be completely documented.  (As stated in class and in the notes, this requires that almost every line be commented.)  In addition, there should be a comment at the top with your name, the date, and a brief description of the program.
;
; Turn in your program source via blackboard. Your filename should be nnn-lab4.asm, where nnn represents your initials.
; For example, if your name is Sammy Bear Kat, and your sam username is sbk001, your filename should be sbk-lab4.asm.
