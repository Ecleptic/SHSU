; Combine Arrays and Function Calls

;;;;;;; Sorting an array of 16-bit integers ;;;;;;;
        org 100h
N equ 7

section .data
a dw 36,24,35,19,72,45,12

selection .text
        push N
        push a
        call sort

        mov ax,4                ;return to dos
        int 21h

sort:
        push bp                 ;save the old bp
        mov bp,sp               ;stack pointer to base pointer.
        mov bx,[bp+4]
        mov cx,[bp+6]

        dec cx                  ; (N-1) loop counter for outer loop

top1:
        mov si,0
        mov di,0
        mov ax,[bx+si]          ;max so far
        mov dx,cx
top2:
        add si,2
        cmp ax,[bx+si]
        jnl skip
