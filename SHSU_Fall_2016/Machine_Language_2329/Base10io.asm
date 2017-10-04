org 100h        ; leave room for program segment prefix
section .data
NUM1 dw   42
NUM2 dw   -100
CRLF db 13,10,'$'
section .text

mov   bx,[NUM1]
call  dec_out       ;print out the first number
mov   dx, CRLF
mov   ah,9
int   21h           ; print a Carriage Return
mov   bx, [NUM2]
call  dec_out       ; print the second number

mov   ah,4Ch
mov   al,0
int   21h           ; return to DOS

dec_out:
push ax
push bx
push cx
push dx

cmp bx,0            ; is bx negative?
jnl skip            ; if not, procede as normal
mov dl, '-'
mov ah,2
int 21h             ; display a minus sign
neg bx              ; and negate bx (so this is now a positive number. Therefore we have a cleaner algorithm)

skip:
mov cx,0
mov ax,bx           ; setup to divide by 10
mov bx, 10
rept1:
mov dx,0            ; dx:ax is the dividend
div bx              ; ax is the quotient, dx is remainder
push dx             ; save the remainder on the stack
inc  cx             ; increment cx so we can loop back to pop off the stack in the right order
cmp ax,0            ; is ax = 0?
jne rept1           ; if not, continue
for1:
pop   dx            ; pop digit off stack
or    dl,30h        ; convert to the ASCII char
mov   ah,2
int   21h           ; display the digit
loop for1           ; loop until cx is 0 (done)


pop dx              ; restore regs
pop cx
pop bx
pop ax
ret
