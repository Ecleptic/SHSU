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
// %token MULTIPLICATIVE  // compare stuffs
%token MULTIPLY
%token DIVIDE
%token MOD
// %token ADDITIVE // compare stuffs
%token ADD
%token SUB
// %token COMPARE
%token EQUAL
%token NOTEQUAL
%token LESSTHAN
%token GREATERTHAN
%token LESSEQUAL
%token GREATEREQUAL
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

program			: PROGRAM beginDeclarations BEGIN beginStatements END
				// | //Error
declarations	:
// type := INT
// statementSequence
// statement
// assignment
// ifStatement
// elseClause
// whileStatement
// writeInt
// expression
// simpleExpression
// term
// factor
// primary


%%

yyerror(char *s)
{
	printf("%s\n", s);
}

main()
{
	yyparse();