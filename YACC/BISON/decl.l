%{
#include "decl.tab.h"
%}

%%

"int"|"float"|"char"|"double"    { return TYPE; }
[a-zA-Z_][a-zA-Z0-9_]*          { return ID; }
[0-9]+                          { return NUM; }
","                             { return ','; }
";"                             { return ';'; }
"="                             { return '='; }
[ \t\n]                         { /* ignore whitespace */ }
.                               { return yytext[0]; }

%%

int yywrap() { return 1; }