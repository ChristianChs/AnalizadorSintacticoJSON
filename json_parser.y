%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

%}

%token STRING NUMBER TRUE FALSE NULL_VALUE

%%

json        : value { printf("JSON válido\n"); }
            ;

value       : object
            | array
            | STRING
            | NUMBER
            | TRUE
            | FALSE
            | NULL_VALUE
            ;

object      : '{' '}'
            | '{' members '}'
            ;

members     : pair
            | pair ',' members
            ;

pair        : STRING ':' value
            ;

array       : '[' ']'
            | '[' elements ']'
            ;

elements    : value
            | value ',' elements
            ;

%%

int main() {
    if (yyparse() == 0) {
        printf("Análisis completado exitosamente.\n");
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}