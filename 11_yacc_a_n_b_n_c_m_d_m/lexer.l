%{
#include "y.tab.h" // Include the YACC header file
%}

%%
"a" { return A; }
"b" { return B; }
"c" { return C; }
"d" { return D; }
\n  { return NEWLINE; }
.   { /* Ignore other characters */ }
%%

int yywrap() {
    return 1;
}
