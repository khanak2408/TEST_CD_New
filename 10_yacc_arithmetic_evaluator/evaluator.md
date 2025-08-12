# Program 10: YACC Arithmetic Evaluator

This program uses `yacc` and `lex` to build a simple command-line calculator that can evaluate arithmetic expressions involving addition (`+`), subtraction (`-`), multiplication (`*`), and division (`/`). It also supports parentheses for grouping and unary minus.

## How it Works

### 1. The Lexer (`lexer.l`)

The lexer is responsible for tokenizing the input string.
*   **Numbers**: It recognizes sequences of digits (`[0-9]+`), converts them to an integer using `atoi()`, and returns the `NUMBER` token. The integer value is stored in the global variable `yylval`, which `yacc` uses to access the token's value.
*   **Operators**: It recognizes single characters `+`, `-`, `*`, `/`, `(`, `)`, and `\n` and returns them directly as tokens.
*   **Whitespace**: Spaces and tabs are skipped.

### 2. The Parser (`evaluator.y`)

The parser defines the grammar of the arithmetic expressions and performs the calculations.

#### Operator Precedence
A key feature of this parser is how it handles operator precedence. Instead of writing complex, recursive grammar rules, we use `yacc`'s built-in directives:
```yacc
%left '+' '-'
%left '*' '/'
%right UMINUS
```
*   `%left` declares that the tokens are left-associative.
*   Rules defined on later lines have higher precedence than those on earlier lines. This ensures that `*` and `/` are evaluated before `+` and `-`.
*   `%right UMINUS` defines a special token `UMINUS` for handling unary minus. Giving it the highest precedence ensures that an expression like `-5 * 3` is parsed as `(-5) * 3`, not `-(5 * 3)`.

#### Grammar Rules
The grammar is defined for an `expr` (expression):
```yacc
expr:
    NUMBER          { $$ = $1; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { /* ... */ }
    | '(' expr ')'  { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
```
*   `$$` refers to the value of the resulting expression.
*   `$1`, `$2`, `$3`, etc., refer to the values of the components on the right-hand side of the rule.
*   When the parser matches a rule (e.g., `expr '+' expr`), it executes the C code in the curly braces, calculating the result and assigning it to `$$`.
*   The division rule includes a check to prevent division by zero.
*   The `UMINUS` rule is used to distinguish unary minus from binary subtraction. The `%prec UMINUS` directive tells `yacc` to give this rule the same precedence as the `UMINUS` token.

## How to Compile and Run

1.  **Install `yacc` (or `bison`) and `lex` (or `flex`):**
    ```bash
    sudo apt-get install bison flex
    ```

2.  **Generate the C files:**
    *   Run `yacc` with the `-d` flag to create `y.tab.c` and the header `y.tab.h`.
    ```bash
    yacc -d evaluator.y
    ```
    *   Run `lex` to create `lex.yy.c`.
    ```bash
    lex lexer.l
    ```

3.  **Compile and Link:**
    ```bash
    gcc y.tab.c lex.yy.c -o evaluator
    ```

4.  **Run:**
    ```bash
    ./evaluator
    ```

### Example Interaction
```
Enter an arithmetic expression (e.g., 5 * (3 + 4)). Press Ctrl+D to exit.
10 + 2 * 6
= 22
(10 + 2) * 6
= 72
-5 * (2+2)
= -20
10 / 0
Error: Division by zero
= 0
```
