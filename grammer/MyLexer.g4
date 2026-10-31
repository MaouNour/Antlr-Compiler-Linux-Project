lexer grammar MyLexer;
CONST: 'const';
LET: 'let';
SEMICOLON : ';';
EQ: '=';
ID: [a-zA-Z][a-zA-Z0-9]+;
WS  : [ \t\r\n]+ -> skip ;
STRING : (~[\r\n])+ ;