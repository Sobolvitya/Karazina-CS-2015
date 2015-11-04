grammar SimpleLanguage;

expr : (init | print | '{' expr '}')+; 
init : ID '=' val ';';
val: ID | INT;
print: 'print' val ';';

ID : [a-zA-Z]+;
INT : [0-9]+ ; // Define token INT as one or more digits
WS : [ \t\r\n]+ -> skip ; // Define whitespace rule, toss it out

