typedef struct Symbol {	/* symbol table entry */
	char	*name;
	short	type;	/* VAR, UNDEF */
	double	val;
	struct Symbol	*next;	/* to link to another */
} Symbol;
Symbol	*install(), *lookup();
