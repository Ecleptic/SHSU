org      100h

section .bss
    buf1: resb 100      ; one input buffer
    buf2: resb 100      ; second input buffer
section .data
; # Prompts for reading strings from user
    CRLF:   db   10, 13 ,"$"
    prmpt1: db CRLF,"Pleas enter the first string: ",'$'
    prmpt2: db CRLF,"Pleas enter the second string: ",'$'
    len1: db CRLF,"The first string has a length of: ",'$'
    len2: db CRLF,"The second string has a length of: ", '$'
    words1: db CRLF,"the first string has a word count of: ",'$'
    words2: db CRLF,"the second string has a word count of: ",'$'
    str1: db CRLF,"the first string is: ",'$'
    str2: db CRLF,"the second string is: ",'$'

section .text

    mov ah, 9			;display str function
    mov dx, msg1		;prepare to display msg
    int 21h				;display
    push buf1
