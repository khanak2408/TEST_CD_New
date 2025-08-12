%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
void yyerror(const char* s);
%}

// Define the tokens from the lexer
%token A B C D NEWLINE

%%
// Grammar rules
program:
    | program statement
    ;

statement:
    sequence NEWLINE { printf("-> Valid string (a^n b^n c^m d^m, where n,m > 0)\n"); }
    | NEWLINE        { /* Ignore empty lines */ }
    | error NEWLINE  { yyerrok; /* Clear the error and continue parsing */ }
    ;

// A valid sequence is an 'ab' part followed by a 'cd' part
sequence:
    part_ab part_cd
    ;

// Rules for a^n b^n, where n > 0
part_ab:
    A B             // Base case: n=1, "ab"
    | A part_ab B   // Recursive step: wraps a smaller valid sequence in 'a' and 'b'
    ;

// Rules for c^m d^m, where m > 0
part_cd:
    C D             // Base case: m=1, "cd"
    | C part_cd D   // Recursive step: wraps a smaller valid sequence in 'c' and 'd'
    ;

%%

// The main function to start the parser
int main() {
    printf("Enter strings (e.g., abcd, aabbcd). Press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}

// Error handling function
void yyerror(const char* s) {
    fprintf(stderr, "-> Invalid string.\n");
}
