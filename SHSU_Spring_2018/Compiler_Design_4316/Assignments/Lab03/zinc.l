%{
/**
*	Cameron Green
* 	Lab 03
* 	Dr. McGuire's Compiler Design
*/


#include <stdio.h>


#define NUM 1
#define IDENT 2 // All Identifiers are Uppercase

#define LP 3
#define RP 4
#define ASGN 5
#define SC 6
#define COLON 7
#define POWER 8
#define MULTIPLICATIVE 9
#define ADDITIVE 10
#define COMPARE 11
#define IF 12
#define THEN 13
#define ELSE 14
#define T_BEGIN 15
#define END 16
#define ENDIF 17
#define ENDWHILE 18
#define WHILE 19
#define LOOP 20
#define PROGRAM 21
#define VAR 22
#define INT 23
#define WRITEINT 24
#define READINT 25
#define COMMENT 26

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

[ \t\n]		// ignore all whitespace
{COMMENT} 	// ignore comments
[\n]				{currentLineNum++;}
{LP}				{ textTemp = yytext; sprintf(tokenTemp, "LP"); return LP; }
{RP}				{ textTemp = yytext; sprintf(tokenTemp, "RP"); return RP; }
{ASGN}				{ textTemp = yytext; sprintf(tokenTemp, "ASGN"); return ASGN; }
{SC}				{ textTemp = yytext; sprintf(tokenTemp, "SC"); return SC; }
{COLON}				{ textTemp = yytext; sprintf(tokenTemp, "COLON"); return COLON; }
{POWER}				{ textTemp = yytext; sprintf(tokenTemp, "POWER"); return POWER; }
{MULTIPLICATIVE}	{ textTemp = yytext; sprintf(tokenTemp, "MULTIPLICATIVE"); return MULTIPLICATIVE; }
{ADDITIVE}			{ textTemp = yytext; sprintf(tokenTemp, "ADDITIVE"); return ADDITIVE; }
{COMPARE}			{ textTemp = yytext; sprintf(tokenTemp, "COMPARE"); return COMPARE; }
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