%{
#include <stdio.h>
int keyword_count = 0;
%}

%%
"alignas" | "alignof" | "and" | "and_eq" | "asm" | "auto" | "bitand" | "bitor" | "bool" | "break" | "case" | "catch" | "char" | "char8_t" | "char16_t" | "char32_t" | "class" | "compl" | "concept" | "const" | "consteval" | "constexpr" | "constinit" | "const_cast" | "continue" | "co_await" | "co_return" | "co_yield" | "decltype" | "default" | "delete" | "do" | "double" | "dynamic_cast" | "else" | "enum" | "explicit" | "export" | "extern" | "false" | "float" | "for" | "friend" | "goto" | "if" | "inline" | "int" | "long" | "mutable" | "namespace" | "new" | "noexcept" | "not" | "not_eq" | "nullptr" | "operator" | "or" | "or_eq" | "private" | "protected" | "public" | "reflexpr" | "register" | "reinterpret_cast" | "requires" | "return" | "short" | "signed" | "sizeof" | "static" | "static_assert" | "static_cast" | "struct" | "switch" | "synchronized" | "template" | "this" | "thread_local" | "throw" | "true" | "try" | "typedef" | "typeid" | "typename" | "union" | "unsigned" | "using" | "virtual" | "void" | "volatile" | "wchar_t" | "while" | "xor" | "xor_eq" { keyword_count++; }

[a-zA-Z_][a-zA-Z0-9_]* { /* This is an identifier, do nothing */ }
. { /* Any other character, do nothing */ }
\n { /* Newline, do nothing */ }
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

    printf("Total number of keywords in '%s': %d\n", argv[1], keyword_count);

    fclose(file);
    return 0;
}
