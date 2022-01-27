
mylang: lex.yy.o parser.tab.o
	gcc -o mylang lex.yy.o parser.tab.o -ly -ll

lex.yy.c: lexer.l parser.tab.c
	flex lexer.l

parser.tab.c: parser.y
	bison -vdtk --report=solved parser.y

clean:
	rm -f mylang
	rm -f lex.yy.*
	rm -f parser.tab.*
	rm -f parser.output