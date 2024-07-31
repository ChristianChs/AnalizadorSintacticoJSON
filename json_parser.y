%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern int yylex();
    extern int yyparse();
    extern FILE *yyin;
    extern char* yytext;
    int errorPrinted = 0;
    void yyerror(const char *detail);
%}

%union
{
    int num;
    char *str;
}

%token TRUE FALSE NULL_TOKEN
%token STRING NUMBER
%token OPEN_BRACE CLOSE_BRACE OPEN_BRACKET CLOSE_BRACKET COLON COMMA
%type <num> NUMBER
%type <str> STRING
%start json

%%
json:       value { printf("\n\t\t\t----> Sintaxis correcta\n\t\t\t----> JSON es valido!\n"); }
            ;
value:      STRING
            | NUMBER
            | TRUE
            | FALSE
            | NULL_TOKEN
            | object
            | array
            ;
object:     OPEN_BRACE members CLOSE_BRACE
            ;
members:    pair
            | pair COMMA members
            ;
pair:       STRING COLON value
            ;
array:      OPEN_BRACKET elements CLOSE_BRACKET
            ;
elements:   value
            | value COMMA elements
            ;
%%

void yyerror(const char *detail) {
    if (!errorPrinted) {
        // Detalle del error
        printf("\t\t\t----> Error: %s\n", detail);
        printf("\t\t\t----> Caracter inesperado o faltante cerca de: '%s'\n\n", yytext);
        errorPrinted = 1;
    }
}
int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "Uso: %s <archivo_entrada>\n", argv[0]);
        return 1;
    }
    yyin = fopen(argv[1], "r");
    if (!yyin)
    {
        perror(argv[1]);
        return 1;
    }
    
    printf("\n\n");
    printf("\t\t\t+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
    printf("\t\t\t+                                                             +\n");
    printf("\t\t\t+                       Analizador de JSON                    +\n");
    printf("\t\t\t+                                                             +\n");
    printf("\t\t\t+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n");

    printf("\t\t\t************** Contenido del archivo de entrada **************\n\n");
    int ch;
    int indentation = 28;
    int isFirstCharacter = 1;
    while ((ch = fgetc(yyin)) != EOF) {
        if (isFirstCharacter) {
        for (int i = 0; i < indentation; ++i) {
            putchar(' ');
        }
        isFirstCharacter = 0;
        }
        putchar(ch);
        if (ch == '\n') {
        isFirstCharacter = 1;
        }
    }

    rewind(yyin);
    
    printf("\n");
    printf("\t\t\t+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
    printf("\t\t\t+                                                             +\n");
    printf("\t\t\t+                      Resultado del Analisis                 +\n");
    printf("\t\t\t+                                                             +\n");
    printf("\t\t\t+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n");
    yyparse();
    fclose(yyin);
    printf("\n\n\n");
    return 0;
}