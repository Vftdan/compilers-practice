tree: FloatExprLexer.class
	grun FloatExpr lang -tree < input.txt
gui: FloatExprLexer.class
	grun FloatExpr lang -gui < input.txt
FloatExprLexer.class: FloatExprLexer.java
	javac FloatExpr*.java
FloatExprLexer.java:
	antlr4 FloatExpr.g4
