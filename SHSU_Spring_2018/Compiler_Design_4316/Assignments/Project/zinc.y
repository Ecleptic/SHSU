%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


char * gen_label();

extern int yylineno;

%}
%union{
	char str[60];
	int num;
}

%token <num>Token_NUM
%token <str>Token_IDENT

%token Token_LP
%token Token_RP
%token Token_ASGN
%token Token_SC
%token Token_COLON
%token Token_POWER
// %token MULTIPLICATIVE  // compare stuffs
%token Token_MULTIPLY
%token Token_DIVIDE
%token Token_MOD
// %token ADDITIVE // compare stuffs
%token Token_ADD
%token Token_SUB
// %token COMPARE
%token Token_EQUAL
%token Token_NOTEQUAL
%token Token_LESSTHAN
%token Token_GREATERTHAN
%token Token_LESSEQUAL
%token Token_GREATEREQUAL
%token Token_IF
%token Token_THEN
%token Token_ELSE
%token Token_BEGIN
%token Token_END
%token Token_ENDIF
%token Token_ENDWHILE
%token Token_WHILE
%token Token_LOOP
%token Token_PROGRAM
%token Token_VAR
%token Token_INT
%token Token_WRITEINT
%token Token_READINT
%token Token_COMMENT




%%
/* productions */
program				: Token_PROGRAM { printf("Section\t.data\n"); } declarations Token_BEGIN /*{ printf("Section\t.code\n"); }*/ statementSequence Token_END { printf("");}
					;

declarations		:  Token_VAR Token_IDENT Token_COLON type Token_SC declarations { printf("");}
					| /*empty*/
					;

type 				:  Token_INT { printf(""); }
					;

statementSequence 	: statement Token_SC statementSequence { printf("");}
					| /*empty*/
					;

statement			: assignment
					| ifStatement { printf("GOTRUE\n");}
					| whileStatement { printf("LOOP\n");}
					| writeInt { printf("RVALUE\n");}
					| /*empty*/
					;

assignment			: Token_IDENT Token_ASGN {printf("LVALUE \t%s\n", $1);} expression {printf("STO\n"); }
					| Token_IDENT Token_ASGN {printf("LVALUE \t%s\n", $1);} {printf("READINT\n");} Token_READINT { printf("STO\n");}
					;


ifStatement			: Token_IF expression Token_THEN {printf("GOFALSE \t%s\n", gen_label());} statementSequence elseClause Token_ENDIF {printf("LABEL \t%s\n", gen_label());}
					|
					;

elseClause			: Token_ELSE statementSequence { printf("");}
					|
					;

whileStatement		: Token_WHILE expression Token_LOOP statementSequence Token_ENDWHILE { printf("");}
					;

writeInt 			: Token_WRITEINT expression {printf("PRINT\n");}
					;



expression			: simpleExpression
					| simpleExpression Token_EQUAL expression { printf("EQ\n");}
					| simpleExpression Token_NOTEQUAL expression { printf("NE\n");}
					| simpleExpression Token_LESSTHAN expression { printf("LT\n");}
					| simpleExpression Token_GREATERTHAN expression { printf("GT\n");}
					| simpleExpression Token_LESSEQUAL expression { printf("LE\n");}
					| simpleExpression Token_GREATEREQUAL expression { printf("GE\n");}
					;
/*
expr				: expr PLUS expr {yycode("ADD\n");}
    				| expr STAR expr {yycode("MUL\n");}
    				| LP expr RP
    				| NUM { yycode("PUSH \t%s\n", $1);}
    				| ID  { yycode("LVALUE\t%s\n", $1);}
					; */

simpleExpression	: term Token_ADD simpleExpression { printf("ADD\n");}
					| term Token_SUB simpleExpression { printf("ADD\n");}
					| term
					;

term				: factor Token_MULTIPLY term { printf("MPY\n");}
					| factor Token_DIVIDE term { printf("DIV\n");}
					| factor Token_MOD term { printf("MOD\n");}
					| factor { printf("**\n");}
					;

factor				: primary Token_POWER factor { printf("");}
					| primary { printf("");}
					;

primary				: Token_IDENT  { printf("RVALUE %s\n", $1); } 
					| Token_NUM { printf("PUSH %d\n", $1);}
					| Token_LP expression Token_RP { printf("");}
					;

// primary             : T_NUM     { printf("PUSH %d\n", $1); }
//                     | T_LP expression T_RP
//                     | T_IDENT   { printf("RVALUE %s\n", $1); }
//                     ;



%%

yyerror(char *s)
{
	// printf("%s at line %s\n", s,line);
	fprintf(stderr, "ERROR: %s (line: %d)\n", s, yylineno);
}
char *gen_label()
{
    static int i = 1000;
    char *temp = malloc(5);
    sprintf(temp,"%04d",i++);
    return temp;
}

void main()
{
	printf("---------------------------------------------------------------\n");
	yyparse();

}
