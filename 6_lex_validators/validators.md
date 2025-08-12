# Program 6: LEX Program for Validation

This program uses `lex` to identify and validate several common patterns from an input stream:
1.  Mobile Numbers
2.  URLs
3.  Identifiers
4.  Dates (dd/mm/yyyy)
5.  Times (hh:mm:ss)

## Logic

The core of this program is a set of regular expressions defined in the definitions section of the `.l` file. `lex` generates a scanner that matches these patterns in the input.

### Regular Expressions Used

1.  **Mobile Number**: `[7-9][0-9]{9}`
    *   This is a simple regex for a 10-digit Indian mobile number.
    *   `[7-9]`: The number must start with a 7, 8, or 9.
    *   `[0-9]{9}`: It must be followed by exactly nine digits (0-9).

2.  **URL**: `(http|https)://[a-zA-Z0-9./-]+`
    *   This is a simplified regex for a web URL.
    *   `(http|https)`: The URL must start with either "http" or "https".
    *   `://`: Followed by "://".
    *   `[a-zA-Z0-9./-]+`: The rest of the URL can contain letters, numbers, dots, forward slashes, and hyphens.

3.  **Identifier**: `[a-zA-Z_][a-zA-Z0-9_]*`
    *   This is the standard definition for an identifier in C-like languages.
    *   `[a-zA-Z_]`: It must start with a letter (a-z, A-Z) or an underscore.
    *   `[a-zA-Z0-9_]*`: It can be followed by zero or more letters, numbers, or underscores.

4.  **Date (dd/mm/yyyy)**: `(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[0-9]{4}`
    *   This regex validates the *format* of a date, but not its logical validity (e.g., it accepts `31/04/2023`).
    *   `dd`: `(0[1-9]|[12][0-9]|3[01])` - Matches days from 01 to 31.
    *   `mm`: `(0[1-9]|1[012])` - Matches months from 01 to 12.
    *   `yyyy`: `[0-9]{4}` - Matches a four-digit year.
    *   `/`: The separator must be a forward slash.

5.  **Time (hh:mm:ss)**: `([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]`
    *   This regex validates a time in 24-hour format.
    *   `hh`: `([01][0-9]|2[0-3])` - Matches hours from 00 to 23.
    *   `mm`: `[0-5][0-9]` - Matches minutes from 00 to 59.
    *   `ss`: `[0-5][0-9]` - Matches seconds from 00 to 59.
    *   `:`: The separator must be a colon.

### How it Works

*   The `main` function prompts the user for input.
*   `yylex()` reads from the standard input.
*   When a piece of input matches one of the defined regular expressions, the corresponding C code block is executed, which prints a message identifying the matched pattern and the matched text (`yytext`).
*   Whitespace and any other characters are ignored.
*   The program runs until it receives the end-of-file signal (Ctrl+D on Linux/macOS).

## How to Compile and Run

1.  **Install `lex` (or `flex`):**
    If not already installed, use a package manager (e.g., `sudo apt-get install flex`).

2.  **Compile the LEX file:**
    This generates `lex.yy.c`.
    ```bash
    lex validators.l
    ```

3.  **Compile the generated C file:**
    ```bash
    gcc lex.yy.c -o validators
    ```

4.  **Run:**
    ```bash
    ./validators
    ```
    The program will then wait for you to type in strings.

### Example Interaction
```
Enter strings to validate (press Ctrl+D to exit):
9876543210
Found a valid Mobile Number: 9876543210
https://www.google.com
Found a valid URL: https://www.google.com
my_variable123
Found a valid Identifier: my_variable123
25/12/2023
Found a valid Date (dd/mm/yyyy): 25/12/2023
14:30:00
Found a valid Time (hh:mm:ss): 14:30:00
invalid
Found a valid Identifier: invalid
```
