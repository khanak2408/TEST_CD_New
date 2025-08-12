# Program 3: Operator Counter

This directory contains two implementations of a program that counts the total number of operators in a given file: one in C and one using LEX.

---

## 1. C Implementation (`operator_counter.c`)

### Logic

1.  **Operator List**: A `const char*` array named `operators` stores all the C operators to be counted.
    *   **Important**: The operators are sorted by length in descending order (e.g., `<<=` comes before `<<` and `<`). This is crucial to ensure the longest possible match is found first, preventing parts of multi-character operators from being counted individually.
2.  **File Reading**: The program takes a filename as a command-line argument and reads the entire file content into a single character buffer.
3.  **String Searching**: The code iterates through the buffer character by character (`pos`).
    *   At each position, it loops through the `operators` array and uses `strncmp` to check for a match.
    *   If an operator is matched, the `operator_count` is incremented, and the `pos` is advanced by the length of the matched operator. The inner loop breaks to avoid shorter matches (e.g., after matching `++`, we don't want to also match `+`).
    *   If no operator is matched at the current position, `pos` is advanced by one character.
4.  **Output**: After scanning the entire buffer, the program prints the total `operator_count`.

### How to Compile and Run

1.  **Compile:**
    ```bash
    gcc operator_counter.c -o operator_counter_c
    ```

2.  **Run:**
    ```bash
    ./operator_counter_c <your_file.c>
    ```
    Replace `<your_file.c>` with the path to the file you want to analyze.

---

## 2. LEX Implementation (`operator_counter.l`)

### Logic

The LEX implementation is more straightforward as `lex` automatically handles finding the longest match.

1.  **Definitions**:
    *   A global integer `operator_count` is initialized to zero.
2.  **Rules**:
    *   A set of rules explicitly lists all the C operators. Any time one of these patterns is matched, the `operator_count` is incremented. Both multi-character and single-character operators are included.
    *   Rules are added to match and consume other common language elements like identifiers, literals, and comments. This is important to ensure that characters within them (e.g., a `*` in a comment) are not mistakenly counted as operators.
    *   A final `.` rule consumes any other character.
3.  **Main Function**:
    *   The `main` function reads a filename from the command line.
    *   It opens the file and assigns it to `yyin`, the lexer's input stream.
    *   `yylex()` starts the scanning process.
    *   When `yylex()` finishes, the program prints the final `operator_count`.

### How to Compile and Run

1.  **Install `lex` (or `flex`):**
    If not already installed, use a package manager (e.g., `sudo apt-get install flex`).

2.  **Compile the LEX file:**
    This generates the C source file `lex.yy.c`.
    ```bash
    lex operator_counter.l
    ```

3.  **Compile the generated C file:**
    ```bash
    gcc lex.yy.c -o operator_counter_lex
    ```

4.  **Run:**
    ```bash
    ./operator_counter_lex <your_file.c>
    ```
    Replace `<your_file.c>` with the path to the file you want to analyze.
