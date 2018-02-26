#include <stdio.h>  // standard i/o prototypes
#include <string.h> // string function prototypes
#include <ctype.h>  // char function prototypes

// constants
#define PLUSSYM '+'
#define MINUSSYM '-'
#define MULTSYM '*'
#define DIVSYM 'div'
#define MODSYM 'mod'
#define OPENPAREN '('
#define CLOSEPAREN ')'
#define BLANK ' '
#define NULLSTRING ""

FILE *infile;
char lookahead;

void open_data_file(int argc, char *argv[])
{
    /* This function opens the data file containign the expression for this
	execution of the compiler. */
    // local variables
    //  char filename[50];
    infile = NULL;
    if (argc > 1)
    {
        if ((infile = fopen(argv[1], "r")) == NULL)
        {
            fprintf(stderr, "Error opening input file:  %s", argv[1]);
        }
    }
    else
        infile = stdin;

} // end open_data_file

void error(char *errstr)
{
    fprintf(stderr, "%s\n", errstr);
} // end error

void parse(void)
{
    int ch;

    while ((ch = fgetc(stdin)) != EOF)
    {
        printf(ch);
    }
}

int main(int argc, char *argv[])
{
    open_data_file(argc, argv);
    parse();
    puts("End of Compilation...");
}
