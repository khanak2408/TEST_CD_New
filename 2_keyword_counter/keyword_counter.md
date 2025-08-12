# Program 2: Keyword Counter

This directory contains two implementations of a program that counts the total number of keywords in a given file: one in C++ and one using LEX.

---

## 1. C++ Implementation (`keyword_counter.cpp`)

### Logic

1.  **Keyword List**: A `std::vector<std::string>` named `keywords` holds all standard C++ keywords.
2.  **File Input**: The program takes a filename as a command-line argument. It opens and reads the file word by word.
3.  **Word Cleaning**: For each `word` read, a simple cleaning loop iterates through its characters. It keeps only alphanumeric characters and underscores (`_`) to form a `clean_word`. This helps in correctly identifying keywords that might be adjacent to punctuation (e.g., `if(`).
4.  **Keyword Check**: The `isKeyword` function checks if the `clean_word` exists in the predefined keyword list.
5.  **Counting**: If the word is a keyword, a counter `keywordCount` is incremented.
6.  **Output**: After reading the entire file, the program prints the total `keywordCount`.

### How to Compile and Run

1.  **Compile:**
    ```bash
    g++ keyword_counter.cpp -o keyword_counter_cpp
    ```

2.  **Run:**
    ```bash
    ./keyword_counter_cpp <your_file.cpp>
    ```
    Replace `<your_file.cpp>` with the path to the file you want to analyze.

---

## 2. LEX Implementation (`keyword_counter.l`)

### Logic

1.  **Definitions**:
    *   A global integer `keyword_count` is initialized to zero.
2.  **Rules**:
    *   A single rule matches any of the C++ keywords using the `|` (OR) operator. When a keyword is matched, the `keyword_count` is incremented.
    *   A rule `[a-zA-Z_][a-zA-Z0-9_]*` matches any other valid identifier. This is important to prevent parts of identifiers from being misidentified as keywords (e.g., `while_loop` should not count `while`).
    *   A catch-all rule `.` and a newline rule `\n` consume any other characters without taking any action.
3.  **Main Function**:
    *   The `main` function checks for a command-line argument (the filename).
    *   It opens the file and assigns its handle to `yyin`, the default input for the lexer.
    *   `yylex()` is called to start the lexical analysis.
    *   After the analysis is complete, it prints the final `keyword_count`.

### How to Compile and Run

1.  **Install `lex` (or `flex`):**
    If you don't have it, install it using your package manager (e.g., `sudo apt-get install flex`).

2.  **Compile the LEX file:**
    This command generates a C source file named `lex.yy.c`.
    ```bash
    lex keyword_counter.l
    ```

3.  **Compile the generated C file:**
    We use a C compiler (like `gcc`) to create the final executable.
    ```bash
    gcc lex.yy.c -o keyword_counter_lex
    ```

4.  **Run:**
    ```bash
    ./keyword_counter_lex <your_file.cpp>
    ```
    Replace `<your_file.cpp>` with the path to the file you want to analyze.
