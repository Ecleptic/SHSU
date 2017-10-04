org      100h
global main
; extern printf, exit
section   .bss
    input1   resb    100      ; one input buffer
    input2 resb 100      ; second input buffer

push bp

section .data
prompt1: db   0dh,0ah,"Please enter the first string: $"
prompt2: db   0dh,0ah,"Please enter the second string: $"
str3:    db   0dh,0ah,"The first string has a length of: $"
str4:    db   0dh,0ah,"The second string has a length of: $"
str5:    db   0dh,0ah,"The first sting has a word count of: $"
str6:    db   0dh,0ah,"The second string has a word count of: $"
prompt3: db   0dh,0ah,"The first string is: $"
str8:    db   0dh,0ah,"The second string is: $"
CRLF:    db   10, 13 ,"$"
char:    db   " "
         db   10, 13 ,"$"
instr1:  db   100, '$'
instr2:  db   100, '$'
store:   db   6, '$' ;TO STORE NUMBER CONVERTED TO STRING.
s:       db   ' =$'
space:   db   ' $'
cnt:     db   0

section .text
mov si, instr1
mov di, instr2

INSTRING:

mov ah, 9
mov dx, prompt1
int 21h

mov ah, 0Ah
mov dx, si
int 21h
;
; mov ah, 9
; mov dx, prompt2
; int 21h
;
; mov ah, 0Ah
; mov dx, di
; int 21h

mov ah, 9
mov dx, CRLF
int 21h

; call LENGTH1
;
; mov ah, 9
; mov dx, CRLF
; int 21h


; call LENGTH2
;
; call WCOUNT1
;
; call WCOUNT2
;
; mov ah, 9
; mov dx, CRLF
; int 21h

call PRINTLN1

call PRINTLN2

; call EXIT:

EXIT:
mov ah, 4Ch                  ; return control to DOS
mov   al,0                       ;exit condition
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

mov si, input1+1
mov cl, byte [si]
mov ch, 00h

l1   :
inc si

cmp byte [si],' '

jnz l2
inc byte [cnt]

l2 : loop l1

add byte [cnt], '0'

mov ah, 09h
mov dx, str5
int 21h

mov ah, 02h
mov dh, 00h
mov dl, [cnt]
int 21h

mov ah, 4ch
int 21h
ret

;WCOUNT2 function
WCOUNT2:
    mov si, input2+1
    mov cl, byte [di]
    mov ch, 00h

    lo1   : inc di

    cmp byte [di],' '

    jnz lo2
    inc byte [cnt]

    lo2 : loop l1

    add byte [cnt], '0'

    mov ah, 09h
    mov dx, str6
    int 21h

    mov ah, 02h
    mov dh, 00h
    mov dl, [cnt]
    int 21h

    mov ah, 4ch
    int 21h
ret

;PRINTLN1 function
PRINTLN1:

push ax                        ; push ax onto the stack
push   bx                            ; save register
push   cx                            ; save loop count
push dx                            ; save register
PRINTLN:
; push ax                        ; push ax onto the stack
; push	bx		                    ; save register
; push	cx		                    ; save loop count
; push dx		                    ;  save register

    mov	     ah,9						; print prompt
    mov	     dx,prompt3
    int 	   21h

    mov si, input1
    cld
    mov cx,bx
    jcxz finPrint
    mov ah,2

  topPrint:
    lodsb
    mov dl,al
    int 21h
    loop topPrint
  finPrint:

  ; pop 	dx		                    ;  restore register
  ; pop		cx	                     	; restore loop count
  ; pop		bx		                    ;  restore register
  ; pop		ax	                     	; restore value
ret
pop    dx                            ; restore register
pop       cx                            ; restore loop count
pop       bx                            ; restore register
pop       ax                            ; restore value
ret

;PRINTLN2 function
PRINTLN2:
push ax                        ; push ax onto the stack
push   bx                            ; save register
push   cx                            ; save loop count
push dx                            ; save register

mov al, [instr2]

mov   [char],al   ; store character in ch

mov   dx, str8 ; offset of 2nd message
mov   ah, 9   ; print string function
int   21h   ; print it

mov   dl,[char]   ; char to display
mov   ah, 2       ; print char function
int   21h       ; display it

pop    dx                            ; restore register
pop       cx                            ; restore loop count
pop       bx                            ; restore register
pop       ax                            ; restore value

ret

;NUMOUT1 function
;NUMOUT1:

;NUMOUT2 function
;NUMOUT2:
