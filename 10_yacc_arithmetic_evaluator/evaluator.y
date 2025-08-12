%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char*);
%}

// Define the token for numbers from the lexer
%token NUMBER

// Define operator precedence and associativity
%left '+' '-'
%left '*' '/'
%right UMINUS // Unary minus

%%
// Grammar rules
program:
    | program line
    ;

line:
    '\n'
    | expr '\n' { printf("= %d\n", $1); }
    ;

expr:
    NUMBER          { $$ = $1; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr {
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | '(' expr ')'  { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    ;
%%

// Main function to start parsing
int main() {
    printf("Enter an arithmetic expression (e.g., 5 * (3 + 4)). Press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}

// Error handling function
void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}
