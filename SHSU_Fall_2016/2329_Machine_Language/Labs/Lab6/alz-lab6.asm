org	  100h
global  main
extern  printf, exit
section	.bss
    input1	resb 	100      ; one input buffer
    input2  resb  100      ; second input buffer


section .data
  str1:    db   0dh,0ah,"Please enter the first string: $"
  str2:    db   0dh,0ah,"Please enter the second string: $"
  str3:    db   0dh,0ah,"The first string has a length of: $"
  str4:    db   0dh,0ah,"The second string has a length of: $"
  str5:    db   0dh,0ah,"The first sting has a word count of: $"
  str6:    db   0dh,0ah,"The second string has a word count of: $"
  str7:    db   0dh,0ah,"The first string is: $"
  str8:    db   0dh,0ah,"The second string is: $"
  newline: db   10, 13 ,"$"
  char:    db   " "
           db   10, 13 ,"$"
  instr1:  db   100, '$'
  instr2:  db   100, '$'
  store:   db   6, '$' ;TO STORE NUMBER CONVERTED TO STRING.
  s:       db   ' =$'
  space:   db   '  $'
  cnt:     db   0

section .text
mov si, instr1        ;str1 into instr1 buffer
mov di, instr2        ;str2 into instr2 buffer

mov ah, 9           ; print str1
mov dx, str1
int 21h

mov ah, 0Ah         ;get users input and save it into si
mov dx, si
int 21h

mov ah, 9           ; print str2
mov dx, str2
int 21h

mov ah, 0Ah         ;get users input and save it into di
mov dx, di
int 21h

mov ah, 9           ;creats a new line
mov dx, newline
int 21h

call LENGTH1          ; calls the LENGTH1 preocedure

mov ah, 9             ;creats a new line
mov dx, newline
int 21h


call LENGTH2          ; calls the LENGTH2 preocedure

call WCOUNT1         ; calls the WCOUNT1 preocedure

call WCOUNT2          ; calls the WCOUNT2 preocedure

mov ah, 9             ;creats a new line
mov dx, newline
int 21h

call PRINTLN1         ; calls the PRINTLN1 preocedure

call PRINTLN2         ; calls the PRINTLN2 preocedure

mov ah, 4Ch                  ; return control to DOS
mov	al,0	                	;exit condition
int 21h

;LENGTH1 function
LENGTH1:
  mov ah, 9
  mov dx, str3
  int 21h

  mov bl, [instr1+1]

  add bl, 30h
  mov ah, 2
  mov dl, bl
  int 21h
  ret

;LENGTH2 function
LENGTH2:
  mov ah, 9
  mov dx, str4
  int 21h

  mov bl, [instr2+1]

  add bl, 30h
  mov ah, 2
  mov dl, bl
  int 21h
  ret

;WCOUNT1 function
WCOUNT1:
mov dx, str5             ; load & display the string_1
mov ah, 9
int 21h

mov ah, 2                    ; carriage return
mov dl, 0dh
int 21h

ret

;WCOUNT2 function
WCOUNT2:
mov dx, str6             ; load & display the string_1
mov ah, 9
int 21h

mov ah, 2                    ; carriage return
mov dl, 0dh
int 21h
ret

;PRINTLN1 function
PRINTLN1:

push ax                        ; push ax onto the stack
push	bx		                    ; save register
push	cx		                    ; save loop count
push dx		                    ;  save register

mov	di,input1
cld                     ;process from left
xor     bx,bx           ;BX holds no. of chars read
mov     ah,1            ;input1 char function
int     21h             ;read a char into AL
WHILE1:	cmp     al,0Dh          ;<CR>?
je      ENDFOR	       ;yes, exit
;if char is backspace
cmp     al,08h          ;is char a backspace?
jne     ELSE1           ;no, store in string
dec     di              ;yes, move string ptr back
dec     bx              ;decrement char counter
jmp     READ            ;and go to read another char
ELSE1:	stosb                   ;store char in string
inc     bx              ;increment char count
READ:	int     21h             ;read a char into AL
jmp     WHILE1          ;and continue loop

ENDFOR:

  mov si, input1
  cld
  mov cx,bx
  jcxz EXIT
  mov ah,2

TOP2:
  lodsb
  mov dl,al
  int 21h
  loop TOP2

EXIT:
  mov	ax,4C00h
  int	21h

  call NUMOUT1

  pop 	dx		                    ;  restore register
  pop		cx	                     	; restore loop count
  pop		bx		                    ;  restore register
  pop		ax	                     	; restore value
ret

;PRINTLN2 function
PRINTLN2:
push ax                        ; push ax onto the stack
push	bx		                    ; save register
push	cx		                    ; save loop count
push dx		                    ;  save register


mov di,input2
cld                     ;process from left
xor     bx,bx           ;BX holds no. of chars read
mov     ah,1            ;input char function
int     21h             ;read a char into AL

WHILE12:
  cmp     al,0Dh          ;<CR>?
  je      ENDWHLE12        ;yes, exit
;if char is backspace
  cmp     al,08h          ;is char a backspace?
  jne     ELSE12           ;no, store in string
  dec     di              ;yes, move string ptr back
  dec     bx              ;decrement char counter
  jmp     READ2            ;and go to read another char
ELSE12:
  stosb                   ;store char in string
  inc     bx              ;increment char count
READ2:
  int     21h             ;read a char into AL
  jmp     WHILE12          ;and continue loop
ENDWHLE12:
mov ah,9 ; print prompt
mov dx,str8
int 21h

  mov byte [di], '$'
  mov ah,9
  mov dx, input2
  int 21h
  mov ax,4C00h
  int 21h


call NUMOUT2

  pop 	dx		                    ;  restore register
  pop		cx	                     	; restore loop count
  pop		bx		                    ;  restore register
  pop		ax	                     	; restore value
ret

;NUMOUT1 function
NUMOUT1:
push ax                        ; push ax onto the stack
push	bx		                    ; save register
push	cx		                    ; save loop count
push  dx		                    ;  save register

mov si, char

inp:    mov ah,01
        int 21h

        mov [si],al

        inc si

        cmp al,0dh
        jnz inp
        mov si,'$'

        mov dx, char
        mov ah,09h
        int 21h

pop 	dx		                    ;  restore register
pop		cx	                     	; restore loop count
pop		bx		                    ;  restore register
pop		ax	                     	; restore value
ret

;NUMOUT2 function
NUMOUT2:
push ax                        ; push ax onto the stack
push	bx		                    ; save register
push	cx		                    ; save loop count
push  dx		                    ;  save register

mov si, char

inp1:    mov ah,01
        int 21h

        mov [si],al

        inc si

        cmp al,0dh
        jnz inp1
        mov si,'$'

        mov dx, char
        mov ah,09h
        int 21h

pop 	dx		                    ;  restore register
pop		cx	                     	; restore loop count
pop		bx		                    ;  restore register
pop		ax	                     	; restore value
ret                 	; restore value
