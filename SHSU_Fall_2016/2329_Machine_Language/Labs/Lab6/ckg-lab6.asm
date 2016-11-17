org 100h
section	.bss
input1	resb 	100
input2	resb 	100

section .data
crlf:    db 13,10,'$'
prompt1: db	"Please enter the first string: $"
prompt2: db	"Please enter the second string: $"
prompt3: db	"The first string is: $"
prompt4: db	0Dh,0Ah, "The second string is: $"
instr1:  db   100, '$'
instr2:  db   100, '$'
str1len: db   100,'$'


section	.text

call INSTRING
; call PRINTLN

; call LENGTH


EXIT:
  mov	ax,4C00h
  int	21h

INSTRING:
push ax                        ; push ax onto the stack
push	bx		                    ; save register
push	cx		                    ; save loop count
push dx		                    ;  save register

    mov	     ah,9						; print prompt
    mov	     dx,prompt1
    int 	   21h

    mov	    di,input1       ; place it in input1? I thought
    cld                     ;process from left
    xor     bx,bx           ;BX holds no. of chars read
    mov     ah,1            ;input1 char function
    int     21h             ;read a char into AL

  whileInstring:
    cmp     al,0Dh                  ;<CR>?
    je      endforInstring	        ;yes, exit
    ;if char is backspace
    cmp     al,08h                  ;is char a backspace?
    jne     elseInstring            ;no, store in string
    dec     di                      ;yes, move string ptr back
    dec     bx                      ;decrement char counter
    jmp     readInstring            ;and go to read another char

  elseInstring:
    stosb                   ;store char in string
    inc     bx              ;increment char count

  readInstring:
    int     21h             ;read a char into AL
    jmp     whileInstring          ;and continue loop

  endforInstring:
  ; pop 	dx		                    ;  restore register
  ; pop		cx	                     	; restore loop count
  ; pop		bx		                    ;  restore register
  ; pop		ax	                     	; restore value
  ; call PRINTLN
; ret

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

  pop 	dx		                    ;  restore register
  pop		cx	                     	; restore loop count
  pop		bx		                    ;  restore register
  pop		ax	                     	; restore value
ret
;
; LENGTH:
; mov	     ah,9						; print prompt
; ; mov	     dx,[input1]
; int 	   21h
;
;     ret

    ; EXIT:
