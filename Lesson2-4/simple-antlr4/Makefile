tree: SimpleAntlrLexer.class
	grun SimpleAntlr lang -tree < input.txt
gui: SimpleAntlrLexer.class
	grun SimpleAntlr lang -gui < input.txt
SimpleAntlrLexer.class: SimpleAntlrLexer.java
	javac SimpleAntlr*.java
SimpleAntlrLexer.java:
	antlr4 SimpleAntlr.g4
