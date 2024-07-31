%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "json_parser.tab.h"
    void yyerror(const char *s);
%}

%%
[ \t\n]
"true"                  { return TRUE; }
"false"                 { return FALSE; }
"null"                  { return NULL_TOKEN; }
\"[^"]*\"               { yylval.str = strdup(yytext); return STRING; }
[-]?[0-9]+(\.[0-9]+)?   { yylval.num = atof(yytext); return NUMBER; }
"{"                     { return OPEN_BRACE; }
"}"                     { return CLOSE_BRACE; }
"["                     { return OPEN_BRACKET; }
"]"                     { return CLOSE_BRACKET; }
":"                     { return COLON; }
","                     { return COMMA; }
.                       { yyerror("Caracter invalidos"); }
%%

int yywrap()
{
    return 1;
}