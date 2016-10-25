; Avery Zamzow
; 10/20/16
; 1.	A procedure READ that lets the user enter a base 10 integer
;     from the keyboard and returns it value in AX.
; 2.	A procedure WRITE that receives a number in AX and displays
;     that number as a base 10 integer.
; 3.	A procedure RANDOM that receives a number in AX and returns
;     the next random number in the AX register.


org	  100h

section .data
   prompt_1   db 'Enter a number in base 10 from 1 - 32767: : $'
   prompt_2   db  0dh,0ah,'The 20 random numbers are :',0dh,0ah,'$'
   retry      db  0dh,0ah,'Invalid number. Try again : $'
   blanks     db  '    $'

   counter_1  db  20, '$'
   counter_2  db  '? $'

section .text

     mov dx, prompt_1             ; load and display prompt_1
     mov ah, 9
     int 21h

     call read                    ; call the procedure read

     push ax                      ; push ax onto the stack

     mov dx, prompt_2             ; load and display the string prompt_2
     mov ah, 9
     int 21h

     pop ax                       ; pop a value from stack to ax

     loop_1:                     ; loop label
       mov byte [counter_2], 1           ; set counter_2=4

       loop_2:                   ; loop label
         push ax                  ; push ax onto the stack

         mov dx, blanks           ; load and display the string blanks
         mov ah, 9
         int 21h

         pop ax                   ; pop a value from stack into ax

         call random              ; call the procedure random
         call write               ; call the procedure write

         dec byte [counter_2]            ; decrement counter_2
         cmp byte [counter_2], 0         ; compare counter_2 with 0
       jne loop_2                ; jump to label loop_2 if counter_2!=0

       dec byte [counter_1]              ; decrement counter_1
       cmp byte [counter_1], 0           ; compare counter_1 with 0
     jne loop_1                  ; jump to label loop_1 if counter_1!=0

     mov ah, 4Ch                  ; return control to DOS
     mov	al,0	                	;exit condition
     int 21h

 read:
   ; this procedure will read a number in binary form
   ; input : none
   ; output : store binary number in ax
   ; uses : main

   jmp start                     ; jump to label start

   again:                        ; jump label

   mov dx, retry                  ; load and display the string again
   mov ah, 9
   int 21h

   start:                        ; jump label

   mov cx, 16                     ; initialize loop counter
   xor bx, bx                     ; clear bx
   mov ah, 1                      ; set input function

   input:                        ; loop label
     int 21h                      ; read a character

     cmp al, 0Dh                  ; compare input and CR
     je end                      ; jump to label end if input is cr

     cmp al, 0h                  ; compare al with 0
     jl again                    ; jump to label again if al<0

     and al, 0Fh                  ; convert ascii to decimal code
     shl bx, 1                    ; shift bx by 1 position towards left
     or  bl, al                   ; place the input decimal digit in bl
   loop input                    ; jump to label @input if cx!=0

   end:                          ; jump label

   cmp bx, 0                      ; compare bx with 0
   jle again                     ; jump tolabel if bx<=0

   mov ax, bx                     ; set ax=bx

   ret                            ; return control to the calling procedure

 write:
   ; this procedure will display a number in binary form
   ; input : ax
   ; output : display the binary number in ax
   ; uses : main

   push ax                        ; push ax onto the stack
   push	bx		                    ; save register
 	 push	cx		                    ; save loop count
 	 push dx		                    ;  save register

   mov		bx, 10	                 ; div by bx
 	 xor		cx, cx	                 ; clear cx for count

   while2:
   	mov		dx, 0	                   ; setup division - upper half 0
   	div		bx		                    ;  begin division

   	push 	dx		                    ; save remainder to stack

   	inc		cx	                    	;  increment counter for pop display
   	cmp 	ax, 0	                   ; check if quotient is 0
   	jne 	while2                   	;  cont if not 0
   	mov		ah, 2	                   ; print char fcn

   loop1:
   	pop 	dx		                   ; pop then print

   	or		dl, 30h	                  ; clear top half of dx
   	int		21h		                   ;  print it

   	loop 	loop1	                   ;  loop times of cx

   	pop 	dx		                    ;  restore register
   	pop		cx	                     	; restore loop count
   	pop		bx		                    ;  restore register
   	pop		ax	                     	; restore value

   	ret		                       		; return to main prog

 random:
   ; this procedure will generate a random number
   ; input : ax
   ; output : ax
   ; uses : main

  push	bx		                     ;save bx to stack

 	xor		bx, bx	                    ;clear bx for use
 	shl		ax, 1	                     ;shift left to set bit 0 later
 	rcl		ax, 1	                     ;bit 15 now CF

 	jc		   one		                  ;if CF 1, set bh to 1
 	jmp		next                     	;else check bit 14

 one:
   mov	bh, 1                      ;bh holds value of bit15

 next:
 rcl	ax, 1	                     ;bit 14 now CF

 	jc		one2                    	;if CF 1, set bl to 1
 	jmp 	next2	                   ;otherwise move on

 one2:
 mov	bl, 1	                     ;bl holds value of bit14

 next2:
 rcr	ax, 2	                     ;reset to original value
 	xor		bh, bl	                 ;perform xor op, then set bit 0 to result
 	cmp		bh, 0	                   ;check result of xor
 	je		zero	                   ;if 0, clear bit 0
 	jmp		not0	                    ;if 1, set bit 0

 zero:
 	and		ax, 0FFFEh	            ;clear bit 0
 	jmp		bottom		               ;skip set

 not0:
 or		ax, 00001h	                ;set bit 0

 bottom:
 	and		ax, 07FFFh	              ;clear bit 15
 	pop		bx			                  ;restore bx
 	ret                              ; return control to the calling procedure
