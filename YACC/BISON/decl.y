%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token TYPE ID NUM

%%

statements:
    | statements statement
    ;

statement:
    TYPE var_list ';' { printf("Valid variable declaration.\n"); }
    ;

var_list:
      var_item
    | var_list ',' var_item
    ;

var_item:
      ID
    | ID '=' NUM
    ;

%%

void yyerror(const char *s) {
    printf("Invalid variable declaration syntax.\n");
}

int main() {
    printf("Enter variable declarations (e.g., 'int a, b = 10;' | Ctrl+D to exit):\n");
    yyparse();
    return 0;
}