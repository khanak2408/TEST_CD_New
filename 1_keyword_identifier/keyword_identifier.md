# Program 1: Keyword Identifier

This program identifies whether a given string is a C++ keyword.

## Logic

1.  **Keyword List**: A `std::vector<std::string>` named `keywords` is pre-populated with all the standard C++ keywords.
2.  **Input**: The program prompts the user to enter a string.
3.  **Check**: The function `isKeyword` takes the user's input string and uses `std::find` to search for it within the `keywords` vector.
4.  **Output**:
    *   If `std::find` locates the string, the function returns `true`, and the program prints that the input is a keyword.
    *   Otherwise, the function returns `false`, and the program prints that the input is not a keyword.

## How to Compile and Run

To compile and run this program, you need a C++ compiler like `g++`.

1.  **Compile the program:**
    ```bash
    g++ keyword_identifier.cpp -o keyword_identifier
    ```

2.  **Run the executable:**
    ```bash
    ./keyword_identifier
    ```

### Example

```
Enter a string to check if it is a keyword: while
'while' is a keyword.
```

```
Enter a string to check if it is a keyword: myvariable
'myvariable' is not a keyword.
```
