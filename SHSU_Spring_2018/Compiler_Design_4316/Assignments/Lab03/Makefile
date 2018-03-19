all:
	flex zinc.l
	gcc lex.yy.c -ll -o zinc
	./zinc < TEST.znc