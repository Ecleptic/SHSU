; print an apppropriate promt
; ask user to enter a char
; display that char on the next line
    org 100h

section .data
prompt  db      "Please, kindly enter a character: ",'$'
crlf    db      13,10,'$'                                   ;carriage return and line feed?

; code section
section .text
; Print a prompt for user input
    ; "function 9" prints to string
        ;input ah=9
        ;dx = address of string
    ; function number should be in the ah register and dx is the address of the string
    mov ah,9        ; display string function
    mov dx,prompt   ; dx has the address of string
    int 21h         ; displays the prompt
    ; "interrupt 21h, function 1" reads a character from the keyboard
        ;input ah = 1
        ;output al = char
; get the character from the user
    mov ah,1        ; read char fcn
    int 21h         ; reads it (invoking 21 hex reads the text.)
; go to the next line
    mov ah,9        ; display string function
    mov dx,crlf     ; display carriage return
    int 21h
;echo the char entered
    ; "interrupt 21h, function 2" reads the character and displays it.
        ;input ah = 2
        ;dl = char to display
    mov dl,al       ; move char into dl
    mov ah,2        ; displays char function
    int 21h         ; Display!
; exit to DOS
    ;"interrupt 21 function 4 c hex" returns to DOS
        ;input: ah = 4c
        ;al = exit code, (o = normal)
    mov ah, 4Ch     ; DOS exit function
    mov al,0        ; normal termination
    int 21h         ; we're done here
