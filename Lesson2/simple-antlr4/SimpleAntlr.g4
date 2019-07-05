
grammar SimpleAntlr;
fragment EOL_CHARS : ('\r\n'|'\r'|'\n');
/*WS : (EOL | [ \t])+ -> skip;*/
/*NOTEOL : ~[\r\n]*;*/
fragment LBRACK : '[';
fragment RBRACK : ']';
fragment LBRACE : '{';
fragment RBRACE : '}';
fragment COMMA : ',';
fragment CARET : '^';
ACTION : '->' ~';'*;
fragment INT : [0-9]+;
fragment SIMPLE_QUANTIFIER: [*+?];
fragment QUOTE : '\'';
fragment ESQSEQ : '\\' .;
//fragment STRING_CHAR : STRING_SIMPLE_CHAR | ESQSEQ | LBRACK | RBRACK | LBRACE | RBRACE | LPAR | RPAR | COMMA | PIPE | COLON | CARET | DOT | TILDE | ID;
fragment STRING_CHAR : STRING_SIMPLE_CHAR;
EXPR_STRING : QUOTE (STRING_CHAR|ESQSEQ)* QUOTE;
fragment STRING_SIMPLE_CHAR : ~('\''|'\\');
fragment EXPLICIT_QUANTIFIER : LBRACE INT? COMMA INT? RBRACE;
/*EXPR_QUANTIFIED : expr QUANTIFIER;*/
/*EXPR_PAR : LPAR expr RPAR;*/
/*EXPR_UNION : expr PIPE EXPR;*/
fragment SET_TERM_CHAR : ~('\\'|']');
fragment SET_CHAR : SET_TERM_CHAR | ESQSEQ;
fragment INLINE_COMMENT_START : '//';
INLINE_COMMENT : (INLINE_COMMENT_START ~('\r'|'\n')* EOL_CHARS) -> skip;
BLOCK_COMMENT_START : '/*';
BLOCK_COMMENT_END : '*/';
/*BLOCK_COMMENT_CONTENT : ([^*]+|)*;*/
BLOCK_COMMENT : (BLOCK_COMMENT_START .*? BLOCK_COMMENT_END) -> skip;
DOT : '.';
PIPE : '|';
TILDE : '~';
LPAR : '(';
RPAR : ')';
QUANTIFIER : SIMPLE_QUANTIFIER | EXPLICIT_QUANTIFIER;
COLON : ':';
SC : ';';
//COMMENT : (INLINE_COMMENT | BLOCK_COMMENT) -> skip;
//COMMENT : BLOCK_COMMENT -> skip;
GRAMMAR_KW : 'grammar ';
FRAGMENT_KW : 'fragment ';
ID : ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;
WS : (' '|'\t'|'\r'|'\n')+ -> skip;
EXPR_SET : LBRACK SET_CHAR+ RBRACK;
/*expr : STRING | EXPR_SET | EXPR_UNION | EXPR_PAR | EXPR_QUANTIFIED;*/
/*expr: exprNotUnion (PIPE? exprNotUnion)*;*/
/*exprNotUnion : EXPR_STRING | EXPR_SET | DOT | LPAR expr RPAR | expr quantifier | ;*/
expr : ID | EXPR_STRING | EXPR_SET | DOT | LPAR expr RPAR | expr PIPE expr | expr QUANTIFIER | TILDE expr | expr expr;
/*expr : exprUnion | exprNotUnion;*/
exprAct : expr ACTION?;
grammarLine : GRAMMAR_KW ID SC;
exprLine : FRAGMENT_KW? ID COLON exprAct SC;
line : grammarLine | exprLine;
lang : line* EOF;
