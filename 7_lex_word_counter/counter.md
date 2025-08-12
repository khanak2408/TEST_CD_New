# Program 7: File Statistics Counter (LEX)

This program uses `lex` to count the number of lines, words, and blank spaces (specifically spaces and tabs) in a given text file. It is a simple implementation similar to the basic functionality of the Unix `wc` command.

## Logic

The program is built around a few simple rules in a `.l` file.

1.  **Counters**: Three global integer variables are declared to keep track of the counts:
    *   `line_count`
    *   `word_count`
    *   `space_count`

2.  **LEX Rules**:
    *   `\n`: This rule matches every newline character. When a newline is found, the `line_count` is incremented.
    *   `[ \t]`: This rule matches any occurrence of a space or a tab character. When matched, the `space_count` is incremented.
    *   `[^\n \t]+`: This is the rule for a "word". It matches any sequence of one or more characters that are *not* a newline, space, or tab. Every time such a sequence is matched, the `word_count` is incremented.
    *   `.`: A catch-all rule is included to consume any other single character without taking any action. This is generally good practice but not strictly necessary here as the previous rules cover all cases.

3.  **`main` Function**:
    *   The program expects a single command-line argument: the path to the file to be analyzed.
    *   It opens the specified file and assigns it to `yyin`, which directs the `lex` scanner to read from this file instead of the default standard input.
    *   It calls `yylex()` to begin the scanning process.
    *   After `yylex()` completes (at the end of the file), the program prints the final values of the three counters.

## How to Compile and Run

1.  **Install `lex` (or `flex`):**
    If you don't have `flex` installed, use your system's package manager.
    ```bash
    sudo apt-get install flex
    ```

2.  **Compile the LEX file:**
    This command generates the C source file `lex.yy.c`.
    ```bash
    lex counter.l
    ```

3.  **Compile the generated C file:**
    Use a C compiler like `gcc`.
    ```bash
    gcc lex.yy.c -o counter
    ```

4.  **Run:**
    Provide the path to a text file as an argument.
    ```bash
    ./counter <your_file.txt>
    ```

### Example

If `your_file.txt` contains:
```
Hello world, this is a test.
Line two.
```

The output will be:
```
File statistics for 'your_file.txt':
  - Lines: 2
  - Words: 8
  - Blank Spaces (spaces and tabs): 6
```
