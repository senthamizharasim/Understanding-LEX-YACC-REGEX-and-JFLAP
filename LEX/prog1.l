%{
#include <stdio.h>
int lines = 0, words = 0, chars = 0, comments = 0;
%}

%x MULTI_COMMENT

%%

"//".*                  { comments++; }
"/*"                    { BEGIN(MULTI_COMMENT); }
<MULTI_COMMENT>"*/"     { comments++; BEGIN(INITIAL); }
<MULTI_COMMENT>\n       { lines++; }
<MULTI_COMMENT>.        { /* skip comment body */ }

\n                      { lines++; chars++; }
[ \t]+                  { chars += yyleng; }
[a-zA-Z0-9_]+           { words++; chars += yyleng; }
.                       { chars++; }

%%

int yywrap() { return 1; }

int main() {
    printf("Enter source text (Press Ctrl+D to finish):\n");
    yylex();
    printf("\n--- Summary ---\n");
    printf("Lines: %d\nWords: %d\nCharacters: %d\nComments: %d\n", 
           lines, words, chars, comments);
    return 0;
}