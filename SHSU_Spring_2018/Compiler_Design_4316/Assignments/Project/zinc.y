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
program				: Token_PROGRAM declarations Token_BEGIN statementSequence Token_END { printf("program \n");}
					;

declarations		: Token_VAR Token_IDENT Token_COLON type Token_SC declarations { printf("declarations \n");}
					| /*empty*/
					;

type 				:  Token_INT
					;

statementSequence 	: statement Token_SC statementSequence { printf("statementSequence \n");}
					| /*empty*/
					;

statement			: assignment { printf("statement1 \n");}
					| ifStatement { printf("statement2 \n");}
					| whileStatement { printf("statement3 \n");}
					| writeInt { printf("statement4 \n");}
					| /*empty*/
					;

assignment			: Token_IDENT Token_ASGN expression { printf("assignment1 \n");}
					| Token_IDENT Token_ASGN Token_READINT { printf("assignment2 \n");}
					;

ifStatement			: Token_IF expression Token_THEN statementSequence elseClause Token_ENDIF { printf("ifStatement \n");}
					|
					;

elseClause			: Token_ELSE statementSequence { printf("elseClause \n");}
					|
					;

whileStatement		: Token_WHILE expression Token_LOOP statementSequence Token_ENDWHILE { printf("whileStatement \n");}
					;

writeInt 			: Token_WRITEINT expression { printf("writeInt \n");}
					;

expression			: simpleExpression { printf("expression1 \n");}
					| simpleExpression Token_EQUAL expression { printf("expression2 \n");}
					| simpleExpression Token_NOTEQUAL expression { printf("expression3 \n");}
					| simpleExpression Token_LESSTHAN expression { printf("expression4 \n");}
					| simpleExpression Token_GREATERTHAN expression { printf("expression5 \n");}
					| simpleExpression Token_LESSEQUAL expression { printf("expression6 \n");}
					| simpleExpression Token_GREATEREQUAL expression { printf("expression7 \n");}
					;

simpleExpression	: term Token_ADD simpleExpression { printf("simpleExpression1 \n");}
					| term Token_SUB simpleExpression { printf("simpleExpression2 \n");}
					| term
					;

term				: factor Token_MULTIPLY term { printf("term1 \n");}
					| factor Token_DIVIDE term { printf("term2 \n");}
					| factor Token_MOD term { printf("term3 \n");}
					| factor { printf("term4 \n");}
					;

factor				: primary Token_POWER factor { printf("factor1 \n");}
					| primary { printf("factor2 \n");}
					;

primary				: Token_IDENT { printf("primary1 \n");}
					| Token_NUM { printf("primary2 \n");}
					| Token_LP expression Token_RP { printf("primary3 \n");}
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

void main()
{
	yyparse();

}