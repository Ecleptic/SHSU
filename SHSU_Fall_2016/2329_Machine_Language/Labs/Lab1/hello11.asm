; TITLE "Case Conversion"
org 100hsection .data
MSG1    DB    'enter a lower case letter: $'
MSG2    DB    0Dh, 0Ah, 'In upper case it is: '
CHAR    DB    ' ','$'
exCode  DB    0
  section .text
;print user prompt
    mov 
