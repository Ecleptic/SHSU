%{
#include "expr4.h"
#include "math.h"

static Symbol *symlist = 0;  /* symbol table: linked list */

%}

%union
{
	double	val;	/* actual value */
	Symbol	*sym;	/* symbol table pointer */
}

%token	<val>	NUMBER
%token	<sym>	VAR UNDEF
%type	<val>	expr asgn
%right	'='
%left	'+' '-'
%left	'*' '/'
%left	UNARYMINUS
%right	'^'	/* exponentiation */
%%
list:	  /* nothing */
	| list '\n'
	| list asgn '\n'
	| list expr '\n'	{ printf("\t%.8g\n", $2); }
	| list error '\n'	{ yyerrok; }
	;
asgn:	  VAR '=' expr { $$=$1->val=$3; $1->type = VAR; }
	;
expr:	  NUMBER
	| VAR {	if ($1->type == UNDEF)
		    execerror("undefined variable", $1->name);
		$$ = $1->val; }
	| asgn
	| expr '+' expr	{ $$ = $1 + $3; }
	| expr '-' expr	{ $$ = $1 - $3; }
	| expr '*' expr	{ $$ = $1 * $3; }
	| expr '/' expr	{
		if ($3 == 0.0)
			execerror("division by zero", "");
		$$ = $1 / $3; }
	| expr '^' expr	{ $$ = pow($1, $3); }
	| '(' expr ')'	{ $$ = $2; }
	| '-' expr  %prec UNARYMINUS  { $$ = -$2; }
	;
%%
	/* end of grammar */
#include <stdio.h>
#include <ctype.h>
char	*progname;
int	lineno = 1;

main(int argc, char *argv[])		/* expr4 */
{
	progname = argv[0];
	yyparse();
}

yylex()		/* expr4 */
{
	int c;

	while ((c=getchar()) == ' ' || c == '\t')
		;
	if (c == EOF)
		return 0;
	if (c == '.' || isdigit(c)) {	/* number */
		ungetc(c, stdin);
		scanf("%lf", &yylval.val);
		return NUMBER;
	}
	if (isalpha(c)) {
		Symbol *s;
		char sbuf[100], *p = sbuf;
		do {
			*p++ = c;
		} while ((c=getchar()) != EOF && isalnum(c));
		ungetc(c, stdin);
		*p = '\0';
		if ((s=lookup(sbuf)) == 0)
			s = install(sbuf, UNDEF, 0.0);
		yylval.sym = s;
		return s->type == UNDEF ? VAR : s->type;
	}
	if (c == '\n')
		lineno++;
	return c;
}
yyerror(char *s)
{
	warning(s, (char *)0);
}

execerror(char *s, char *t)	/* recover from run-time error */
{
	warning(s, t);
}

warning(char *s, char *t)
{
	fprintf(stderr, "%s: %s", progname, s);
	if (t && *t)
		fprintf(stderr, " %s", t);
	fprintf(stderr, " near line %d\n", lineno);
}



Symbol *lookup(char *s)	/* find s in symbol table */
{
	Symbol *sp;

	for (sp = symlist; sp != (Symbol *) NULL; sp = sp->next)
		if (strcmp(sp->name, s) == 0)
			return sp;
	return 0;	/* 0 ==> not found */
}

Symbol *install(char *s, int t, double d)  /* install s in symbol table */
{
	Symbol *sp;
	void *emalloc();

	sp = (Symbol *) emalloc(sizeof(Symbol));
	sp->name = emalloc(strlen(s)+1); /* +1 for '\0' */
	strcpy(sp->name, s);
	sp->type = t;
	sp->val = d;
	sp->next = symlist; /* put at front of list */
	symlist = sp;
	return sp;
}

void *emalloc(unsigned n)	/* check return from malloc */
{
	void *p;

	p = (void *) malloc(n);
	if (p == NULL)
		execerror("out of memory", (char *) 0);
	return p;
}
