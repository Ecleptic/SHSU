
%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <math.h>
%}


%option noyywrap


DIV "div"
MOD "mod"
PROGRAM "program"
VAR "var"



%%

[ \t\n]	; // ignore all whitespace
[0-9]+			printf("<\"%s\", INT>\n",yytext);
([a-z]|[A-Z])+	printf("<\"%s\", ident>\n",yytext);
"("		        printf("<\"%s\", OPENPAREN>\n",yytext);
")"		        printf("<\"%s\", CLOSEPAREN>\n",yytext);
":="	        printf("<\"%s\", ASSIGNEQUAL>\n",yytext);
";"		        printf("<\"%s\", SC>\n",yytext);
"**"		    printf("<\"%s\", EXPONENT>\n",yytext);
"*"		        printf("<\"%s\", MPY>\n",yytext);
"div"		    printf("<\"%s\", DIV>\n",yytext);
{MOD}		    printf("<\"%s\", MOD>\n",yytext);
"+"		        printf("<\"%s\", ADD>\n",yytext);
"-"		        printf("<\"%s\", SUBTRACT>\n",yytext);
"="		        printf("<\"%s\", EQUALBOOL>\n",yytext);
"<>"		    printf("<\"%s\", OPENCLOSEBRACKET>\n",yytext);
"<"		        printf("<\"%s\", LESSTHAN>\n",yytext);
"<="		    printf("<\"%s\", LESSEQUAL>\n",yytext);
">"		       printf("<\"%s\", GREATERTHAN>\n",yytext);
">="		    printf("<\"%s\", GREATEREQUAL>\n",yytext);
{PROGRAM}		printf("<\"%s\", PROGRAM>\n",yytext);
{VAR}		    printf("<\"%s\", VAR>\n",yytext);

%%

/*** C Code section ***/

int main(void)
{
	/* Call the lexer, then quit. */
	yylex();
	return 0;
}