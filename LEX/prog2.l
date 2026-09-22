%{
#include <stdio.h>
%}

DIGIT       [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGIT})*
NUM         {DIGIT}+(\.{DIGIT}+)?
RELOP       (==|!=|<=|>=|<|>)

%%

"if"|"else"|"while"|"int"|"float"|"return"   { printf("[KEYWORD: %s]\n", yytext); }
{RELOP}                                      { printf("[RELOP: %s]\n", yytext); }
"="                                          { printf("[ASSIGN_OP]\n"); }
";"|","|"{"|"}"|"("|")"                      { printf("[DELIMITER: %s]\n", yytext); }
{NUM}                                        { printf("[NUMBER: %s]\n", yytext); }
{ID}                                         { printf("[IDENTIFIER: %s]\n", yytext); }
[ \t\n]+                                     { /* ignore whitespace */ }
.                                            { printf("[UNKNOWN: %s]\n", yytext); }

%%

int yywrap() { return 1; }

int main() {
    printf("Enter code snippet to tokenize (Ctrl+D to end):\n");
    yylex();
    return 0;
}