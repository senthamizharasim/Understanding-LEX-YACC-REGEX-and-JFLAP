%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

input:
    | input line
    ;

line:
      '\n'
    | expr '\n' { printf("Result = %d\n", $1); }
    ;

expr:
      NUMBER              { $$ = $1; }
    | expr '+' expr       { $$ = $1 + $3; }
    | expr '-' expr       { $$ = $1 - $3; }
    | expr '*' expr       { $$ = $1 * $3; }
    | expr '/' expr       { 
                            if ($3 == 0) {
                                yyerror("Division by zero");
                                $$ = 0;
                            } else {
                                $$ = $1 / $3;
                            }
                          }
    | '(' expr ')'        { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter arithmetic expressions (Ctrl+D to exit):\n");
    yyparse();
    return 0;
}