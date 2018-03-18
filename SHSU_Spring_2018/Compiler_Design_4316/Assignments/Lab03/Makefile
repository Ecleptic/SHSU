all: zinc

zinc.tab.c zinc.tab.h:	zinc.y
	bison -d zinc.y

lex.yy.c: zinc.l zinc.tab.h
	flex zinc.l

zinc: lex.yy.c zinc.tab.c zinc.tab.h
	gcc -o zinc zinc.tab.c lex.yy.c

clean:
	rm zinc zinc.tab.c lex.yy.c zinc.tab.h