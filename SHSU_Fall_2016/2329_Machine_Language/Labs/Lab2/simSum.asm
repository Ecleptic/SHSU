org 100h

section .data
prompt  db      "?","$"
crlf    db      13,10,'$'                                   ;carriage return and line feed?
crlfhx  db      0Dh,0Ah,'$'                                 ;carriage return and line feed?
NUM1:    DB      0,"$"
NUM2:    DB      0,"$"
ANS:     DB      ' ','$'
; dw
;
; section	.bss
; temp:	resw	1

section .text
; print a prompt
mov ah,09h                         ; display string function
mov dx,prompt                      ; dx has the address of string
int 21h                            ; displays the prompt

; get the num from the user
mov     ah,01h                     ; read char fcn
int     21h                        ; input char into AL
sub     al,30h                      ; convert to number
mov     [NUM1],al                  ;  and store it
; get num 2
mov     ah,01h                     ; read char fcn
int     21h                        ; input char into AL
sub     al,30h                     ; convert to number
mov     [NUM2],al                  ;  and store it

mov     dx, crlf                   ; get second message
 mov     ah,9                      ; display string function
 int     21h

;
 ; fadd    [NUM1],1                 ;  this sets NUM1 := NUM1 + NUM2


 mov al,[NUM2]
 add al, [NUM1]
 add al,30h
 mov [NUM1],al



; mov ah,9
; mov dx,crlf
; int 21h
mov ah,9
mov dx,NUM1
int 21h
; mov ah,9
; mov dx,NUM2
; int 21h


; exit to DOS
mov ah, 4Ch     ; DOS exit function
mov al,0h       ; normal termination
int 21h         ; we're done here







; Convert to Decimal
ConvertNumber:
    push ax            ; Save modified registers
    push bx
    push dx
    ; mov si, bufferend  ; Start at the end
.convert:
    xor dx, dx         ; Clear dx for division
    div bx             ; Divide by base
    add dl, '0'        ; Convert to printable char
    cmp dl, '9'        ; Hex digit?
    jbe .store         ; No. Store it
    add dl, 'A'-'0'-10 ; Adjust hex digit
.store:
    dec si             ; Move back one position
    mov [si], dl       ; Store converted digit
    and ax, ax         ; Division result 0?
    jnz .convert       ; No. Still digits to convert
    pop dx             ; Restore modified registers
    pop bx
    pop ax
    ret
