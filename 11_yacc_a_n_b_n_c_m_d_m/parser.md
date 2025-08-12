# Program 11: YACC Recognizer for `a^n b^n c^m d^m`

This program uses `yacc` and `lex` to validate strings against the context-free grammar `a^n b^n c^m d^m`, where `n` and `m` must be greater than 0.

This language consists of two concatenated parts:
1.  A sequence of one or more 'a's followed by an equal number of 'b's.
2.  Followed immediately by a sequence of one or more 'c's followed by an equal number of 'd's.

Examples of valid strings include `abcd` (n=1, m=1) and `aabbcd` (n=2, m=1).

## Grammar Used

The language `a^n b^n c^m d^m` is a classic example of a context-free language that is not regular. It can be elegantly defined with a recursive grammar. The YACC parser implements the following rules:

```yacc
// A valid sequence is an 'ab' part followed by a 'cd' part
sequence:
    part_ab part_cd
    ;

// Rules for a^n b^n, where n > 0
part_ab:
    A B             // Base case for n=1: "ab"
    | A part_ab B   // Recursive case: a(a^n-1 b^n-1)b
    ;

// Rules for c^m d^m, where m > 0
part_cd:
    C D             // Base case for m=1: "cd"
    | C part_cd D   // Recursive case: c(c^m-1 d^m-1)d
    ;
```
This grammar is "center-recursive". For example, to parse `aaabbb`, the parser effectively does the following:
*   It matches the outermost `a` and `b`.
*   It then tries to match the inner string `aabb` against the `part_ab` rule again.
*   This continues until it reaches the base case `ab`.

## How it Works

1.  **`lexer.l`**: The lexer tokenizes the input stream. It returns the token `A` for the character 'a', `B` for 'b', `C` for 'c', and `D` for 'd'. It also passes `NEWLINE` characters to the parser to enable line-by-line processing.

2.  **`parser.y`**: The parser (`yyparse()`) receives tokens from the lexer and tries to construct a valid parse tree according to the grammar.
    *   If the entire input string on a line can be reduced to a valid `sequence`, the success message is printed.
    *   If at any point the tokens do not match the grammar rules (e.g., `acbd`, `aabbc`), `yyerror` is called and an error message is printed.

## How to Compile and Run

1.  **Install `yacc` (or `bison`) and `lex` (or `flex`):**
    ```bash
    sudo apt-get install bison flex
    ```

2.  **Generate the C files:**
    *   First, run `yacc` with the `-d` flag to create `y.tab.c` and the header `y.tab.h` (which the lexer needs).
    ```bash
    yacc -d parser.y
    ```
    *   Next, run `lex`.
    ```bash
    lex lexer.l
    ```

3.  **Compile and Link:**
    ```bash
    gcc y.tab.c lex.yy.c -o parser
    ```

4.  **Run:**
    ```bash
    ./parser
    ```

### Example Interaction
```
Enter strings (e.g., abcd, aabbcd). Press Ctrl+D to exit.
abcd
-> Valid string (a^n b^n c^m d^m, where n,m > 0)
aabbcd
-> Valid string (a^n b^n c^m d^m, where n,m > 0)
abccdd
-> Valid string (a^n b^n c^m d^m, where n,m > 0)
aabbccdd
-> Valid string (a^n b^n c^m d^m, where n,m > 0)
acbd
-> Invalid string.
abbd
-> Invalid string.
abc
-> Invalid string.
```
