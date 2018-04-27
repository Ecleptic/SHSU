%{
#include <stdio.h>
#include <ctype.h>
/* #include <malloc.h> */
#include <string.h>
#include <stdlib.h>

#define yycode printf

#define YYSTYPE char*
char * gen_label();

%}

%token NUM
%token IDENT

%token LP
%token RP
%token ASGN
%token SC
%token COLON
%token POWER
%token MULTIPLICATIVE
%token ADDITIVE
%token COMPARE
%token IF
%token THEN
%token ELSE
%token BEGIN
%token END
%token ENDIF
%token ENDWHILE
%token WHILE
%token LOOP
%token PROGRAM
%token VAR
%token INT
%token WRITEINT
%token READINT
%token COMMENT



%%

%%
#include "lex.yy.c"
char *gen_label()
{
    static int i = 1000;
    char *temp = malloc(5);
    sprintf(temp,"%04d",i++);
    return temp;
}

yyerror(char *s)
{
    printf("%s\n", s);
}

main()
{
    yyparse();