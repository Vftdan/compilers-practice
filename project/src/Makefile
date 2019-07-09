class : java
	cd ../out && javac *.java && cd $$OLDPWD
java : clean
	antlr4 ANTLRv4Lexer.g4 -o ../out
	antlr4 ANTLRv4Parser.g4 -o ../out
	if ls *.java 2> /dev/null; then cp *.java ../out; fi
clean :
	mkdir -p ../out
	rm ../out/* 2> /dev/null || true
tree :
	cd ../out && grun ANTLRv4Parser grammarSpec -tree && cd $$OLDPWD
gui :
	cd ../out && grun ANTLRv4 grammarSpec -gui && cd $$OLDPWD
main :
	cd ../out && java ANTLRv4Parser < ../../Lesson2-4/simple-antlr4/SimpleAntlr.g4 && cd $$OLDPWD
.PHONY: java class clean tree gui
