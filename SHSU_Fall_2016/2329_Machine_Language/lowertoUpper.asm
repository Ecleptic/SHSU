;TITLE "Case Conversion“
    org 100h
section .data
MSG1    DB    'Enter a lower case letter: $'
MSG2    DB    0Dh,0Ah,'In upper case it is: '
CHAR    DB    ' ','$'
exCode  DB    0
section .text
;print user prompt
   mov     ah,09h                   ; display string fcn
   mov     dx, MSG1                 ; get first message
   int     21h                      ; display it
;input a character and convert to upper case
   mov     ah,1                     ; read char fcn
   int     21h                      ; input char into AL
   sub     al,20h                   ; convert to upper case
   mov     [CHAR],al                ;  and store it
;display on the next line
   mov     dx, MSG2                 ; get second message
   mov     ah,9                     ; display string function
   int     21h                      ; display message and upper case
;return to DOS
Exit:
   mov     ah,4Ch                   ; DOS function: Exit program
   mov     al,[exCode]              ; Return exit code value
   int     21h                      ; Call DOS.  Terminate program
