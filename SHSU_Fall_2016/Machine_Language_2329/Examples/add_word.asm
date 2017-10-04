; Program ADD WORDS
	org 100h
section .data
WORD1   DW      2
WORD2   DW      5

section .text
MAIN:
        PUSH    word [WORD1]
        PUSH    word [WORD2]
        CALL    ADD_WORDS
        MOV     AH,4Ch
        INT     21h

ADD_WORDS:       
;adds two memory words
;stack on entry: return addr.(top), word2, word1
;output: AX = sum
       PUSH    BP              ;save BP
       MOV     BP,SP
       MOV     AX,[BP+6]       ;AX gets WORD1
       ADD     AX,[BP+4]       ;AX has sum
       POP     BP              ;restore BP
       RET     4               ;exit
