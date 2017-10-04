; THIS IS BROKEN!! DO NOT EXPECT IT!

org 100h
section .data
mov bx,0        ; bx will hold input value
mov ah,1        ; input character function
int 21h         ; Input character into al

while1:
cmp al,0DH      ; is char = CR?
je  endwhile    ; if so, we're done
shl bx,1        ; multiply bx by 2

and al,1        ; max out all but least significant bin_out (which would convert from ascii to binary)
; now I need to add to bx. (bx is 16 bit and al is 8bit. I can't add them.) But I do know i'm adding a zero or a one.
; using or for clever addition ()
or bl,al        ; bl is the lower 8 bits of bx. This would "Add" input to bx
int 21h         ; read next digit
jmp while1     ; loops back to while1

endwhile:
; TODO: NOW I NEED TO PRINNT IT BACK OUT

mov ah,9
mov dx,bx
int 21h

; exit to DOS
mov ah, 4Ch     ; DOS exit function
mov al,0h       ; normal termination
int 21h         ; we're done here
