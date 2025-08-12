%{
#include <stdio.h>

int vowel_count = 0;
int consonant_count = 0;
%}

%%
[aeiouAEIOU] { vowel_count++; }
[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z] { consonant_count++; }

.|\n { /* Ignore all other characters (numbers, symbols, whitespace) */ }
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

    printf("Counts for file '%s':\n", argv[1]);
    printf("  - Vowels: %d\n", vowel_count);
    printf("  - Consonants: %d\n", consonant_count);

    fclose(file);
    return 0;
}
