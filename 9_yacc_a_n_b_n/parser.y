%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
void yyerror(const char* s);
%}

// Define the tokens that the lexer will provide
%token A B NEWLINE

%%
// The grammar rules
program:
    | program statement
    ;

statement:
    sequence NEWLINE { printf("-> Valid string (a+b+)\n"); }
    | NEWLINE        { /* Ignore empty lines */ }
    | error NEWLINE  { yyerrok; /* Clear the error and continue parsing */ }
    ;

sequence:
    a_part b_part
    ;

a_part:
    A
    | a_part A
    ;

b_part:
    B
    | b_part B
    ;

%%

// The main function to start the parser
int main() {
    printf("Enter strings (e.g., aaab, abbb). Press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}

// Error handling function
void yyerror(const char* s) {
    fprintf(stderr, "-> Invalid string. It does not match the a+b+ grammar.\n");
}
