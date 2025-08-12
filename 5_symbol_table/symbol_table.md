# Program 5: Symbol Table Implementation in C

This program implements a simple symbol table with insert, delete, and display operations. It uses a hash table with chaining (linked lists) to handle collisions.

## Data Structures

1.  **`Symbol` Struct**: Represents a single entry in the symbol table.
    ```c
    typedef struct Symbol {
        char* name;         // The identifier's name
        struct Symbol* next; // Pointer to the next symbol in case of a collision
    } Symbol;
    ```
    For a real-world compiler, this struct would be extended to include attributes like data type, scope, memory location, etc.

2.  **`hashTable` Array**: The core of the symbol table.
    ```c
    Symbol* hashTable[TABLE_SIZE];
    ```
    It's an array of pointers to `Symbol` structs. Each index in the array acts as a "bucket". If multiple symbols hash to the same index, they are stored in a linked list starting at that index.

## Logic

1.  **Hashing**:
    *   A hash function `unsigned int hash(const char* name)` is used to compute an index in the `hashTable` for a given symbol name.
    *   The chosen hash function is a simple, common algorithm that shifts and adds the ASCII values of the characters in the name, which provides a good distribution. The result is taken modulo `TABLE_SIZE` to fit within the array bounds.

2.  **`insert(const char* name)`**:
    *   It calculates the hash index for the given `name`.
    *   It creates a new `Symbol` node and allocates memory for it.
    *   The new symbol is inserted at the beginning of the linked list at the calculated index. This is the simplest way to handle chaining.

3.  **`delete_symbol(const char* name)`**:
    *   It finds the hash index for the `name`.
    *   It traverses the linked list at that index to find the symbol with the matching name.
    *   If found, it removes the node from the linked list by adjusting the `next` pointers of the surrounding nodes and frees the allocated memory for the node and its name.
    *   It handles cases where the symbol is the first in the list or not in the list at all.

4.  **`display()`**:
    *   It iterates through the entire `hashTable` from index 0 to `TABLE_SIZE - 1`.
    *   For each index that is not empty, it traverses the linked list and prints the names of all the symbols stored in that bucket.

5.  **`main()` Function**:
    *   Provides a simple, menu-driven command-line interface.
    *   The user can choose to insert, delete, or display symbols, or exit the program.
    *   It includes a `free_table()` function that is called on exit to release all dynamically allocated memory, preventing memory leaks.

## How to Compile and Run

1.  **Compile:**
    Use a C compiler like `gcc`.
    ```bash
    gcc symbol_table.c -o symbol_table
    ```

2.  **Run:**
    ```bash
    ./symbol_table
    ```

    The program will then display an interactive menu:
    ```
    Symbol Table Operations:
    1. Insert a symbol
    2. Delete a symbol
    3. Display symbol table
    4. Exit
    Enter your choice:
    ```
