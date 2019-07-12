//Comment
grammar Hello;
r : HELLO ID ;
HELLO : 'hello' ;
ID : [a-z]+ ;
WS : [ \t\r\n]+ -> skip ;
