%{
/**
*	Cameron Green
* 	Lab 03
* 	Dr. McGuire's Compiler Design
*/


#include <stdio.h>
#include <y.tab.h>

char *textTemp;
char tokenTemp[15];
int tablePlace = 0;
int currentLineNum;

// name of the symtab
typedef struct {
	char Lexeme[10];
	char Type[15];
	int Address;
} symbols;
symbols symbolTable[100];


void pushSymTab(int token, char* textTemp){
	// printf("<\"%s\", %d> at %d\n ", textTemp, token, tablePlace);
	int i;
	for( i = 0; i < tablePlace; i ++ ){
		if(strcmp(symbolTable[i].Lexeme,textTemp) == 0){
			return;
		}
	}
	strcpy(symbolTable[tablePlace].Lexeme, textTemp);
	strcpy(symbolTable[tablePlace].Type, tokenTemp);
	symbolTable[tablePlace].Address = tablePlace;
	tablePlace ++;
}

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
/* MULTIPLICATIVE "*"|"div"|"mod"*/
MULTIPLY "*"
DIVIDE "div"
MOD "mod"
/* ADDITIVE "+"|"-"*/
ADD "+"
SUB "-"
/* COMPARE "="|"<>"|"<"|">"|"<="|">="*/
EQUAL "="
NOTEQUAL "<>"
LESSTHAN "<"
GREATERTHAN ">"
LESSEQUAL "<="
GREATEREQUAL ">="

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

[ \t\n]		// ignore all whitespace
{COMMENT} 	// ignore comments
[\n]				{currentLineNum++;}
{LP}				{ textTemp = yytext; sprintf(tokenTemp, "LP"); return LP; }
{RP}				{ textTemp = yytext; sprintf(tokenTemp, "RP"); return RP; }
{ASGN}				{ textTemp = yytext; sprintf(tokenTemp, "ASGN"); return ASGN; }
{SC}				{ textTemp = yytext; sprintf(tokenTemp, "SC"); return SC; }
{COLON}				{ textTemp = yytext; sprintf(tokenTemp, "COLON"); return COLON; }
{POWER}				{ textTemp = yytext; sprintf(tokenTemp, "POWER"); return POWER; }
{MULTIPLY}			{textTemp = yytext; sprintf(tokenTemp, "MULTIPLY"); return MULTIPLY}
{DIVIDE}			{textTemp = yytext; sprintf(tokenTemp, "DIVIDE"); return DIVIDE}
{MOD}				{textTemp = yytext; sprintf(tokenTemp, "MOD"); return MOD}
{ADD}				{textTemp = yytext; sprintf(tokenTemp, "ADD"); return ADD}
{SUB}				{textTemp = yytext; sprintf(tokenTemp, "SUB"); return SUB}
{EQUAL}				{textTemp = yytext; sprintf(tokenTemp, "EQUAL"); return EQUAL}
{NOTEQUAL}			{textTemp = yytext; sprintf(tokenTemp, "NOTEQUAL"); return NOTEQUAL}
{LESSTHAN}			{textTemp = yytext; sprintf(tokenTemp, "LESSTHAN"); return LESSTHAN}
{GREATERTHAN}		{textTemp = yytext; sprintf(tokenTemp, "GREATERTHAN"); return GREATERTHAN}
{LESSEQUAL}			{textTemp = yytext; sprintf(tokenTemp, "LESSEQUAL"); return LESSEQUAL}
{GREATEREQUAL}		{textTemp = yytext; sprintf(tokenTemp, "GREATEREQUAL"); return GREATEREQUAL}
{IF}				{ textTemp = yytext; sprintf(tokenTemp, "IF"); return IF; }
{THEN}				{ textTemp = yytext; sprintf(tokenTemp, "THEN"); return THEN; }
{ELSE}				{ textTemp = yytext; sprintf(tokenTemp, "ELSE"); return ELSE; }
{BEGIN}				{ textTemp = yytext; sprintf(tokenTemp, "T_BEGIN"); return T_BEGIN; }
{END}				{ textTemp = yytext; sprintf(tokenTemp, "END"); return END; }
{ENDIF}				{ textTemp = yytext; sprintf(tokenTemp, "ENDIF"); return ENDIF; }
{ENDWHILE}			{ textTemp = yytext; sprintf(tokenTemp, "ENDWHILE"); return ENDWHILE; }
{WHILE}				{ textTemp = yytext; sprintf(tokenTemp, "WHILE"); return WHILE; }
{LOOP}				{ textTemp = yytext; sprintf(tokenTemp, "LOOP"); return LOOP; }
{PROGRAM}			{ textTemp = yytext; sprintf(tokenTemp, "PROGRAM"); return PROGRAM; }
{VAR}				{ textTemp = yytext; sprintf(tokenTemp, "VAR"); return VAR; }
{INT}				{ textTemp = yytext; sprintf(tokenTemp, "INT"); return INT; }
{WRITEINT}			{ textTemp = yytext; sprintf(tokenTemp, "WRITEINT"); return WRITEINT; }
{READINT}			{ textTemp = yytext; sprintf(tokenTemp, "READINT"); return READINT; }
{NUM}				{ textTemp = yytext; sprintf(tokenTemp, "NUM"); return NUM; }
{IDENT}				{ textTemp = yytext; sprintf(tokenTemp, "IDENT"); return IDENT; }
.					printf("unexpected token %s\n",yytext); /* Ignore any non defined occurance */
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

	int token;
	printf("\nStarting scan\n");
	while((token = yylex()) != 0)
	{
		printf("<\"%s\", %s>\n", textTemp, tokenTemp);
		if(token == 2){
			pushSymTab(token, textTemp);
		}
	}
	printf("\nEnding scan\n");
	int a;

	// dump symbol table
	printf("\nPrinting Symbol Table\n");
	printf("Lexeme\tType\tAddress\n");
	for( a = 0; a < tablePlace; a ++ ){
	  printf("%s\t", symbolTable[a].Lexeme);
	  printf("%s\t", symbolTable[a].Type);
	  printf("%d\t", symbolTable[a].Address);
	  printf("\n");

	return 0;
}