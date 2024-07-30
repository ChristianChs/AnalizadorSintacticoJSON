%{
#include "json_parser.tab.h"
%}

%%

\"([^\\\n]|\\["\\/bfnrt]|\\u[0-9a-fA-F]{4})*\"    { return STRING; }
-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][-+]?[0-9]+)?   { return NUMBER; }
"true"                                           { return TRUE; }
"false"                                          { return FALSE; }
"null"                                           { return NULL_VALUE; }
[ \t\n\r]+                                       { /* ignorar espacios en blanco */ }
"{"                                              { return '{'; }
"}"                                              { return '}'; }
"["                                              { return '['; }
"]"                                              { return ']'; }
":"                                              { return ':'; }
","                                              { return ','; }
.                                                { printf("Carácter inesperado: %s\n", yytext); }

%%
