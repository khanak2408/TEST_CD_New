%{
#include <stdio.h>
int operator_count = 0;
%}

%%
"<<" | ">>" | "<=" | ">=" | "==" | "!=" | "&&" | "||" | "++" | "--" | "->" | "+=" | "-=" | "*=" | "/=" | "%=" | "&=" | "^=" | "|=" | "<<=" | ">>=" { operator_count++; }
"+" | "-" | "*" | "/" | "%" | "<" | ">" | "=" | "!" | "&" | "|" | "^" | "~" | "?" | ":" | "." | "," { operator_count++; }

[a-zA-Z_][a-zA-Z0-9_]* { /* Identifier */ }
[0-9]+ { /* Integer literal */ }
\"(\\.|[^"\\])*\" { /* String literal */ }
\'(\\.|[^'\\])*\' { /* Char literal */ }
.|\n { /* Other characters */ }
%%

int yywrap(void) {
    return 1;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Error: Could not open file '%s'\n", argv[1]);
        return 1;
    }

    yyin = file;
    yylex();

    printf("Total number of operators in '%s': %d\n", argv[1], operator_count);

    fclose(file);
    return 0;
}
