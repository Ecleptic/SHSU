# Learning Makefiles from Stian

# Label
all: Compiler # dependency* technically what we're going to compile

# Specify what happens with the dependency
Compiler:
	gcc -Wall Compiler.c -o Compiler.o

clean:
	rm -rf *.o compiler

silent:
	gcc -w Compiler.c -o Compiler.o

run: silent
	./Compiler