
grammar SimpleAntlr;
/*EOL : ('\r\n'|'\r'|'\n');*/
/*WS : (EOL | [ \t])+ -> skip;*/
/*NOTEOL : ~[\r\n]*;*/
/*INLINE_COMMENT_START : '//';*/
/*INLINE_COMMENT : INLINE_COMMENT_START ~EOL* EOL;*/
BLOCK_COMMENT_START : '/*';
BLOCK_COMMENT_END : '*/';
/*BLOCK_COMMENT_CONTENT : ([^*]+|)*;*/
BLOCK_COMMENT : BLOCK_COMMENT_START .*? BLOCK_COMMENT_END;
/*comment : (INLINE_COMMENT | BLOCK_COMMENT);*/
COMMENT : BLOCK_COMMENT -> skip;
GRAMMAR_KW : 'grammar ';
FRAGMENT_KW : 'fragment ';
LBRACK : '[';
RBRACK : ']';
LBRACE : '{';
RBRACE : '}';
LPAR : '(';
RPAR : ')';
COMMA : ',';
PIPE : '|';
COLON : ':';
CARET : '^';
DOT : '.';
TILDE : '~';
INT : [0-9]+;
ACTION : '->' ~';'*;
ID : ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;
SC : ';';
SIMPLE_QUANTIFIER: [*+?];
QUOTE : '\'';
WS : (' '|'\t'|'\r'|'\n')+ -> skip;
ESQSEQ : '\\' .;
STRING_CHAR : STRING_SIMPLE_CHAR | ESQSEQ | LBRACK | RBRACK | LBRACE | RBRACE | LPAR | RPAR | COMMA | PIPE | COLON | CARET | DOT | TILDE | ID;
exprString : QUOTE (STRING_CHAR|ESQSEQ)* QUOTE;
STRING_SIMPLE_CHAR : ~('\''|'\\');
explicitQuantifier : LBRACE INT? COMMA INT? RBRACE;
quantifier : SIMPLE_QUANTIFIER | explicitQuantifier;
/*EXPR_QUANTIFIED : expr QUANTIFIER;*/
/*EXPR_PAR : LPAR expr RPAR;*/
/*EXPR_UNION : expr PIPE EXPR;*/
SET_TERM_CHAR : ~('\\'|']');
SET_CHAR : SET_TERM_CHAR | ESQSEQ;
exprSet : TILDE LBRACK SET_CHAR+ RBRACK;
/*expr : STRING | exprSet | EXPR_UNION | EXPR_PAR | EXPR_QUANTIFIED;*/
/*expr: exprNotUnion (PIPE? exprNotUnion)*;*/
/*exprNotUnion : exprString | exprSet | DOT | LPAR expr RPAR | expr quantifier | ;*/
expr : exprString | exprSet | DOT | LPAR expr RPAR | expr PIPE expr | expr quantifier;
/*expr : exprUnion | exprNotUnion;*/
exprAct : expr ACTION?;
grammarLine : GRAMMAR_KW ID SC;
exprLine : (FRAGMENT_KW WS)? ID COLON exprAct SC;
line : grammarLine | exprLine;
lang : line* EOF;
