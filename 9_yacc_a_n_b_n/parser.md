# Program 9: YACC Recognizer for `a+b+`

This program uses `yacc` (with `lex`) to recognize strings composed of one or more 'a's followed by one or more 'b's (e.g., `ab`, `aaab`, `abbb`).

## Interpreting the Ambiguous Requirement

The original request was to "recognize strings `aaab`, `abbb` using `a^nb^n`". This contains a contradiction:
*   The grammar `a^nb^n` requires the number of 'a's to be equal to the number of 'b's.
*   The example strings `aaab` (a=3, b=1) and `abbb` (a=1, b=3) do not follow this rule.

Given this conflict, this implementation assumes the **example strings (`aaab`, `abbb`) represent the user's true intent**. These examples belong to the language of "one or more 'a's followed by one or more 'b's". This language is described by the regular expression `a+b+` and can be defined by the following context-free grammar.

## Grammar Used

The YACC parser implements the following grammar:

```
S -> A' B'
A' -> 'a' | A' 'a'
B' -> 'b' | B' 'b'
```

In the `parser.y` file, this is written as:
```yacc
sequence: a_part b_part ;
a_part:   A | a_part A ;
b_part:   B | b_part B ;
```
*   `a_part` matches one or more `A` tokens (representing 'a').
*   `b_part` matches one or more `B` tokens (representing 'b').
*   A valid `sequence` must have the `a_part` followed immediately by the `b_part`.

## How it Works

1.  **`lexer.l`**: The lexer's role is simple. It reads the input stream and provides tokens to the parser.
    *   If it sees the character 'a', it returns the token `A`.
    *   If it sees 'b', it returns the token `B`.
    *   It also returns a `NEWLINE` token for end-of-line, which helps the parser process input line by line.

2.  **`parser.y`**: The parser (`yyparse()`) attempts to match the stream of tokens from the lexer against the defined grammar.
    *   If the input string (e.g., `aaab`) perfectly matches the `sequence` rule, the corresponding action is executed, printing a "Valid string" message.
    *   If the input (e.g., `a`, `b`, `aba`, `bbaa`) does not match the grammar, the `yyerror` function is called, which prints an "Invalid string" message. The `error` token in the grammar helps the parser recover and continue processing subsequent lines.

## How to Compile and Run

1.  **Install `yacc` (or `bison`) and `lex` (or `flex`):**
    ```bash
    sudo apt-get install bison flex
    ```

2.  **Generate the Parser and Lexer C files:**
    *   First, run `yacc` (or `bison`) on the parser file. The `-d` flag is important; it creates the header file `y.tab.h` which defines the tokens (`A`, `B`) for the lexer.
    ```bash
    yacc -d parser.y
    ```
    This generates `y.tab.c` and `y.tab.h`.

    *   Next, run `lex` on the lexer file.
    ```bash
    lex lexer.l
    ```
    This generates `lex.yy.c`.

3.  **Compile and Link the C files:**
    Use a C compiler to link all the generated C files into a single executable.
    ```bash
    gcc y.tab.c lex.yy.c -o parser
    ```

4.  **Run:**
    ```bash
    ./parser
    ```
    The program will wait for you to enter strings.

### Example Interaction
```
Enter strings (e.g., aaab, abbb). Press Ctrl+D to exit.
aaab
-> Valid string (a+b+)
abbb
-> Valid string (a+b+)
ab
-> Valid string (a+b+)
aabb
-> Valid string (a+b+)
aa
-> Invalid string. It does not match the a+b+ grammar.
bb
-> Invalid string. It does not match the a+b+ grammar.
aba
-> Invalid string. It does not match the a+b+ grammar.
```
