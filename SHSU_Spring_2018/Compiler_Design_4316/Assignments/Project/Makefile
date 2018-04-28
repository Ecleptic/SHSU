all:
	flex zinc.l
	bison -y -d zinc.y
	gcc y.tab.c lex.yy.c -ly -ll -o zinc

run: all
	./zinc < input.txt

test: all
	./zinc < test.txt

if: all
	./zinc < if.txt