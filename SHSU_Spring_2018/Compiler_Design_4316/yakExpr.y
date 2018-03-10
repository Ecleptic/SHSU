%{
#define YYSTYPE double /* data type of the yacc stack  so it can handle doubles*/
%}
%token NUMBER
%token ADDSYM
%token SUBSYSTEM
%token MULSYM
%token DIVSYM
%token NEWLINE
%token LPAREN
%token RPAREN

%%
list :      /* does nothing */
    | list NEWLINE
    | list expr NEWLINE     {printf("\t%.8g\n",$2);} /* $2 print second expression */
    ;
expr:   expr ADDSYM term {$$ = $1 + $3;}
    | expr SYBSYM term {$$ =  $1 - $3;}
    | term  {$$ = $1;}
    ;
term:   term MULSYM fact {$$ = $1 * $3;}


#include <stdio.h>
#include <ctype.h>

/* atof == alpha to float.. makes a string a float. */
/* yacc -vd (verbose,debug) <filename> */
/* lex <lex-filename> */