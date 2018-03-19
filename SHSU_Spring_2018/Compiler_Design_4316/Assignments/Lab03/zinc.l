
%{
/* C code to be copied verbatim */
#include <stdio.h>
%}


%option noyywrap

NUM ("+"|"-")?[1-9][0-9]*|0
IDENT [A-Z][_A-Z0-9]*

LP "("
RP ")"
ASGN ":="
SC ";"
COLON ":"
POWER "**"
MULTIPLICATIVE "*"|"div"|"mod"
ADDITIVE "+"|"-"
COMPARE "="|"<>"|"<"|">"|"<="|">="
IF "if"
THEN "then"
ELSE "else"
BEGIN "begin"
END "end"
ENDIF "endif"
ENDWHILE "endwhile"
WHILE "while"
LOOP "loop"
PROGRAM "program"
VAR "var"
INT "integer"
WRITEINT "writeInt"
READINT "readInt"
COMMENT "--".*?




%%
[ \t\n]	 // ignore all whitespace
{COMMENT} // ignore comments
{LP}	        	printf("<\"%s\", OPENPAREN>\n",yytext);
{RP}	        	printf("<\"%s\", CLOSEPAREN>\n",yytext);
{ASGN}	        	printf("<\"%s\", ASSIGNEQUAL>\n",yytext);
{SC}		   		printf("<\"%s\", SC>\n",yytext);
{COLON}		   		printf("<\"%s\", COLON>\n",yytext);
{POWER}		    	printf("<\"%s\", EXPONENT>\n",yytext);
{MULTIPLICATIVE} 	printf("<\"%s\", MULTIPLICATIVE>\n",yytext);
{ADDITIVE}	       	printf("<\"%s\", ADDITIVE>\n",yytext);
{COMPARE}			printf("<\"%s\", COMPARE>\n",yytext);
{IF}		       	printf("<\"%s\", IF>\n",yytext);
{THEN}		       	printf("<\"%s\", THEN>\n",yytext);
{ELSE}		       	printf("<\"%s\", ELSE>\n",yytext);
{BEGIN}		       	printf("<\"%s\", BEGIN>\n",yytext);
{END}		       	printf("<\"%s\", END>\n",yytext);
{ENDIF}		       	printf("<\"%s\", ENDIF>\n",yytext);
{ENDWHILE}		    printf("<\"%s\", ENDWHILE>\n",yytext);
{WHILE}				printf("<\"%s\", WHILE>\n",yytext);
{LOOP}				printf("<\"%s\", LOOP>\n",yytext);
{PROGRAM}		    printf("<\"%s\", PROGRAM>\n",yytext);
{VAR}		       	printf("<\"%s\", VAR>\n",yytext);
{INT}		       	printf("<\"%s\", INT>\n",yytext);
{WRITEINT}		    printf("<\"%s\", WRITEINT>\n",yytext);
{READINT}		    printf("<\"%s\", READINT>\n",yytext);
{NUM}		    	printf("<\"%s\", NUM>\n",yytext);
{IDENT}		    	printf("<\"%s\", IDENT>\n",yytext);

%%

/*** C Code section ***/

int main(int argc, char** argv)
{
	/* Call the lexer, then quit. */
	if(argc > 0){
		yyin = fopen(argv[1],"r");
	}else{
		yyin = stdin;
	}
	yylex();
	return 0;
}