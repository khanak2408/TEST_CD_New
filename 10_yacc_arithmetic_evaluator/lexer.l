%{
#include "y.tab.h" // YACC header
#include <stdlib.h> // For atoi

void yyerror(const char*);
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[-+*/()\n]  { return *yytext; }
[ \t]       { /* Skip whitespace */ }
.           { yyerror("Invalid character"); }
%%

int yywrap() {
    return 1;
}
