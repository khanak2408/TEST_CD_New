%{
#include <stdio.h>
%}

/* Regular Expression Definitions */
MOBILE_NO   [7-9][0-9]{9}
URL         (http|https)://[a-zA-Z0-9./-]+
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*
DATE        (0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}
TIME        ([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]

%%

{MOBILE_NO} { printf("Found a valid Mobile Number: %s\n", yytext); }
{URL}       { printf("Found a valid URL: %s\n", yytext); }
{DATE}      { printf("Found a valid Date (dd/mm/yyyy): %s\n", yytext); }
{TIME}      { printf("Found a valid Time (hh:mm:ss): %s\n", yytext); }
{IDENTIFIER} { printf("Found a valid Identifier: %s\n", yytext); }

\n          { /* Ignore newlines */ }
.           { /* Ignore other characters */ }

%%

int yywrap(void) {
    return 1;
}

int main() {
    printf("Enter strings to validate (press Ctrl+D to exit):\n");
    yylex();
    return 0;
}
