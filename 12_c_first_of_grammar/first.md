# Program 12: C Program to Find the First of a Grammar

This program computes the `First` set for each non-terminal in a given context-free grammar. The `First` set of a non-terminal is the set of all terminals (including epsilon, denoted here by `@`) that can appear as the first symbol in a string derived from that non-terminal.

## Algorithm and Logic

The program implements a simplified version of the standard algorithm to compute `First` sets.

1.  **Grammar Representation**:
    *   The user is prompted to enter the number of production rules and the rules themselves (e.g., `E->TR`).
    *   The grammar is stored in a 2D character array `productions`.
    *   Non-terminals are expected to be uppercase letters, and terminals are lowercase letters or symbols. Epsilon (ε) is represented by the `@` character.

2.  **Data Structures**:
    *   `first_sets[10][10]`: A 2D character array to store the resulting `First` set for each non-terminal.
    *   `first_set_counts[10]`: An integer array to keep track of the number of terminals in each `First` set.

3.  **`find_first()` Function**:
    *   This is the core function that populates the `First` set for a given non-terminal.
    *   It iterates through all productions looking for rules that belong to the current non-terminal.
    *   **Rule 1**: If a production starts with a terminal (e.g., `A->a...`), that terminal is added to `First(A)`.
    *   **Rule 2**: If a production starts with a non-terminal (e.g., `A->B...`), the algorithm recursively calls `find_first()` on `B` to compute its `First` set if it hasn't been computed already. Then, `First(B)` is added to `First(A)`.
    *   **Epsilon (`@`) Handling**:
        *   If `First(B)` contains epsilon in a rule `A->B...`, this simplified implementation adds epsilon to `First(A)`.
        *   **Note**: A complete implementation would proceed to check the next symbol in the production (e.g., in `A->BC`, if `First(B)` contains `@`, it would then add `First(C)` to `First(A)`). This implementation simplifies this step, which is a common approach for introductory lab exercises.

4.  **`add_to_first_set()` Function**:
    *   A helper utility to add a terminal to a `First` set while ensuring no duplicates are added.

5.  **`main()` Function**:
    *   Collects the grammar from the user.
    *   Calls `find_first()` for each unique non-terminal to compute all `First` sets.
    *   Handles the case where a non-terminal appears on the left-hand side of multiple productions (e.g., `A->a` and `A->b`) by ensuring all computed sets are merged correctly.
    *   Finally, it iterates through and prints the computed `First` set for each unique non-terminal.

## How to Compile and Run

1.  **Compile:**
    Use a C compiler like `gcc`.
    ```bash
    gcc first.c -o first
    ```

2.  **Run:**
    ```bash
    ./first
    ```
    The program will then prompt you to enter the grammar.

### Example Interaction

**Input:**
```
Enter the number of productions: 5
Enter the productions (e.g., E->TR, use '@' for epsilon):
E->TR
R->+TR
R->@
T->FU
U->*FU
U->@
F->(E)
F->i
```
*(Note: For this program, you would need to enter each alternate production on a new line, so 8 productions in total for the classic expression grammar)*

**Example with a simpler grammar:**
**Input:**
```
Enter the number of productions: 4
Enter the productions (e.g., E->TR, use '@' for epsilon):
S->AB
A->a
A->@
B->b
```

**Expected Output:**
```
First sets:
FIRST(S) = { a b }
FIRST(A) = { a @ }
FIRST(B) = { b }
```
