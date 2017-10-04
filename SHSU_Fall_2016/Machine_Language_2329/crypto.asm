; Encrypt a character  from keyboard to character 2 and then decrypt it back.

        org 100h

  CIPHER equ 0Fh
  ; section .data
  section .bss
  char resb 1

  section .text
; print a prompt
  mov   ah,2                    ;display character function
  mov   dl,'?'                  ;? prompt
  int   21h                     ;do it

; read a char from keyboard
  mov   ah,1                    ;read char function
  int   21h                     ;read it into al (don't know how)

; encrypt the char and store it.
  xor   al,CIPHER               ;it's encrypted
  mov   [char],al               ;we're storing it into the byte (that's the bracket I guess?)

; display the encrypted char
  mov   dl,[char]               ;
  mov   ah,2                    ;
  int   21h                     ;do it

; decrypt the char & display it
  xor   byte[char],CIPHER       ;xor is on the byte. not the text
  mov   dl,[char]
  int   21h                     ;do it

; say goodbye
mov     ah,4Ch
mov     al,0
int     21h
