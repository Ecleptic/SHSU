%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calc.tab.h"

%}

%%

[ \t]	; // ignore all whitespace
[0-9]+\.[0-9]+ 	{yylval.fval = atof(yytext); return T_FLOAT;}
/ // [0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
[0-9]+		{return INT;}
([a-z]|[A-Z])+	{return ident;}
\n		        {return T_NEWLINE;}
"("		        {return OPENPAREN;}
")"		        {return CLOSEPAREN;}
":="	        {return ASSIGNEQUAL;}
";"		        {return SC;}
"**"		    {return EXPONENT;}
"*"		        {return MULTIPLY;}
"div"		    {return DIV;}
"mod"		    {return MOD;}
"+"		        {return ADD;}
"-"		        {return SUBTRACT;}
"="		        {return EQUALBOOL;}
"<>"		    {return OPENCLOSEBRACKET;}
"<"		        {return LESSTHAN;}
"<="		    {return LESSEQUAL;}
">"		        {return GREATERTHAN;}
">="		    {return GREATEREQUAL;}
"program"		{return PROGRAM;}
"var"		    {return VAR;}

%%