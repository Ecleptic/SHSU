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
msg1:     DB 'Enter a decimal number : $'
msg2:     DB  0DH,0AH,'The 20 random numbers are :',0DH,0AH,'$'
again:    DB  0DH,0AH,'Invalid Number. Try Again : $'
blank:    DB  '    $'

counter1:  DB  '20 $'
counter2:  DB  '  $'

section .text
    mov dx, msg1                ; load and display msg1
    mov ah, 9
    int 21h

    call read           ; call the procedure read

    push ax                      ; push ax onto the stack

    mov dx, msg2                 ; load and display the string msg2
    mov ah, 9
    int 21h

    pop ax                       ; pop a value from stack to ax

    loop_1:                     ; loop label
      mov cx, 4                  ; set counter2 = 4
      mov [counter2],cx

      loop_2:                   ; loop label
        push ax                  ; push ax onto the stack

        mov dx, blank           ; load and display the string blank
        mov ah, 9
        int 21h

        pop ax                   ; pop a value from stack into ax

        call random              ; call the procedure random
        call write               ; call the procedure write

        dec counter2            ; decrement counter2
        cmp counter2, 0         ; compare counter2 with 0
      jne loop_2                ; jump to label loop_2 if counter2!=0

      dec counter1              ; decrement counter1
      cmp counter1, 0           ; compare counter1 with 0
    jne loop_1                  ; jump to label LOOP_1 if COUNTER1!=0

    mov ah, 04CH                  ; DOS function: Exit program
    mov al, 0                   ; Return exit code value
    int 21h                     ;Call DOS.  Terminate program



read:
   ; this procedure will read a number indecimal form
   ; input : none
   ; output : store binary number in ax
   ; uses : main

     jmp start                      ; jump to label read

   error:                        ; jump label
     mov dx, again                ; load and display the string again
     mov ah, 9
     int 21h

   start:                         ; jump label
     xor bx, bx                     ; clear bx
     xor cx, cx                     ; clear cx

     mov ah, 1                      ; set input function
     int 21h                        ; read a character

     cmp al, "-"                    ; compare al with "-"
     je minus                      ; jump to label minus if al="-"

     cmp al, "+"                    ; compare al with "+"
     je plus                       ; jump to label plus if al="+"
     jmp input                     ; jump to label input

   minus:                        ; jump label
     mov cx, 1                      ; set cx=1

   plus:                         ; jump label
     int 21h                        ; read a character
     cmp al, 0Dh                    ; compare AL with CR
     je end                        ; jump to label end if al=cr

   input:                        ; jump label
     cmp al, 30h                  ; compare AL with 0
     jl error                    ; jump to label error if al<0

     cmp al, 39h                  ; compare AL with 9
     jg error                    ; jump to label error if al>9

     and ax, 000Fh                ; convert ascii to decimal code

     push ax                      ; push ax onto the stack

     mov ax, 10                   ; set ax=10
     mul bx                       ; set ax=ax*bx
     mov bx, ax                   ; set bx=ax

     pop ax                       ; pop a value from stack into ax

     add bx, ax                   ; set bx=ax+bx

     mov ah, 1                    ; set input function
     int 21h                      ; read a character

     cmp al, 0Dh                  ; compare AL with CR
     jne input                   ; jump to label if al!=cr

   end:                          ; jump label

     or cx, cx                      ; check cx is 0 or not
     je exit                       ; jump to label exit if cx=0
     neg bx                        ; negate bx

   exit:                         ; jump label
     mov ax, bx                    ; set AX=BX
     ret                            ; return control to the calling procedure

write:
    ; this procedure will display a decimal number
    ; input : ax
    ; output : none
    ; uses : main

      cmp ax, 0                      ; compare ax with 0
      jge start1                     ; jump to label start if ax>=0
      mov ah, 2                      ; set output function
      mov dl, "-"                    ; set dl='-'
      int 21h                        ; print the character

      neg ax                         ; take 2's complement of ax

    start1:                        ; jump label

      mov bx, ax                     ; set ax=bx
      xor cx, cx                     ; clear cx
      mov ax, 10                     ; set ax=10

    repeat:                       ; loop label
      xor dx, dx                   ; clear dx
      div ax                       ; divide ax by ax
      push dx                      ; push dx onto the stack
      inc cx                       ; increment cx
      or bx, bx                    ; take or of bx with bx
    jne repeat                    ; jump to label repeat if zf=0

    mov ah, 2                      ; set output function

    display:                      ; loop label
      pop dx                       ; pop a value from stack to dx
      or dl, 30h                   ; convert decimal to ascii code
      int 21h                      ; print a character
      loop display                  ; jump to label display if cx!=0

    ret                            ; return control to the calling procedure


random:
; this procedure will generate a random number
; input : AX
; output : AX
; uses : MAIN

      shl ax, 1                      ; shift ax towards left by 1 position
      xor dx, dx                     ; clear dx

      test ax, 8000h                 ; test the 15-bit of ax
      jne fifteen_bit               ; jump to label fifteen_bit if 15-bit = 1
      jmp skip_1                    ; jump to label skip_1

    fifteen_bit:                  ; jump label
      mov dh, 1                      ; set dh = 1

    skip_1:                       ; jump label
      test ax, 4000h                 ; test the 14-bit of ax
      jne fourteen_bit              ; jump to label fourteen_bit if 14-bit = 1
      jmp skip_2                    ; jump to label skip_2

    fourteen_bit:                 ; jump label
      mov dl, 1                      ; set DL = 1

    skip_2:                       ; jump label
      xor dh, dl                     ; take xor of dh & dl
      and ax, 0FFFEH                 ; clear 0-bit of AX
      or al, dh                      ; set LSB of AL by XOR of DH & DL
      and ax, 7FFFH                  ; clear 15-bit of AX

      ret                            ; return control to the calling procedure
