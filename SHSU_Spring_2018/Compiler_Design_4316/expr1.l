%}

delim   [\t]
ws      {delim} + digit[0-9]
number  {digit}+\.? | {digit}*\.{digit}+
%%

{ws}            {/*no action*/}
{number}        {yylval = atof(yytext); return (NUMBER);}
"+"             {return (ADDSYM);}
