all:
	flex zinc.l
	gcc lex.yy.c -ll -o zinc
	./zinc < test.znc

# all:
# 	bison -vdy zinc.y
# 	flex zinc.l
# 	gcc y.tab.c -ll
# 	./a.out < test.znc