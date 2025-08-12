#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// List of C operators, sorted by length in descending order to handle multi-character operators correctly.
const char* operators[] = {
    // Three-character operators
    "<<=", ">>=",
    // Two-character operators
    "->", "++", "--", "<<", ">>", "<=", ">=", "==", "!=", "&&", "||",
    "+=", "-=", "*=", "/=", "%=", "&=", "^=", "|=",
    // One-character operators
    "+", "-", "*", "/", "%", "<", ">", "=", "!", "&", "|", "^", "~", "?", ":", ".", ",",
    NULL // Sentinel value to mark the end of the array
};

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    // Read the entire file into a buffer
    fseek(file, 0, SEEK_END);
    long fsize = ftell(file);
    fseek(file, 0, SEEK_SET);

    char* buffer = (char*)malloc(fsize + 1);
    if (!buffer) {
        fprintf(stderr, "Memory allocation failed\n");
        fclose(file);
        return 1;
    }
    fread(buffer, 1, fsize, file);
    fclose(file);
    buffer[fsize] = '\0';

    int operator_count = 0;
    char* pos = buffer;

    while (*pos) {
        int matched = 0;
        // Check for each operator in our list
        for (int i = 0; operators[i] != NULL; ++i) {
            size_t len = strlen(operators[i]);
            if (strncmp(pos, operators[i], len) == 0) {
                operator_count++;
                pos += len; // Advance past the matched operator
                matched = 1;
                break; // Found the longest possible match, move to next position
            }
        }

        if (!matched) {
            pos++; // No operator found at this position, move to the next character
        }
    }

    printf("Total number of operators in '%s': %d\n", argv[1], operator_count);

    free(buffer);
    return 0;
}
