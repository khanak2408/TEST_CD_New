%{
#include <stdio.h>

int line_count = 0;
int word_count = 0;
int space_count = 0;
%}

%%
\n      { line_count++; }
[ \t]   { space_count++; }
[^\n \t]+ { word_count++; }
.       { /* Any other character, do nothing */ }
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

    // The number of lines is usually counted as number of newlines + 1,
    // if the file is not empty and doesn't end with a newline.
    // However, counting newlines is a common interpretation.
    // Let's report all three counts.
    printf("File statistics for '%s':\n", argv[1]);
    printf("  - Lines: %d\n", line_count);
    printf("  - Words: %d\n", word_count);
    printf("  - Blank Spaces (spaces and tabs): %d\n", space_count);

    fclose(file);
    return 0;
}
