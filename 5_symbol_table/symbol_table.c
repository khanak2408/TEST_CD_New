#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TABLE_SIZE 100

// Structure for a symbol table entry
typedef struct Symbol {
    char* name;
    // In a real compiler, you would add more fields like type, scope, etc.
    // char* type;
    // int scope;
    struct Symbol* next;
} Symbol;

// The hash table
Symbol* hashTable[TABLE_SIZE];

// Hash function to compute index
unsigned int hash(const char* name) {
    unsigned int hash_val = 0;
    while (*name) {
        hash_val = (hash_val << 5) + *name++;
    }
    return hash_val % TABLE_SIZE;
}

// Initialize the hash table
void init_hash_table() {
    for (int i = 0; i < TABLE_SIZE; i++) {
        hashTable[i] = NULL;
    }
}

// Insert a symbol into the table
void insert(const char* name) {
    unsigned int index = hash(name);
    Symbol* new_symbol = (Symbol*)malloc(sizeof(Symbol));
    if (!new_symbol) {
        fprintf(stderr, "Memory allocation failed\n");
        return;
    }
    new_symbol->name = strdup(name);
    if (!new_symbol->name) {
        fprintf(stderr, "Memory allocation failed\n");
        free(new_symbol);
        return;
    }
    new_symbol->next = hashTable[index];
    hashTable[index] = new_symbol;
    printf("Inserted '%s' into the symbol table.\n", name);
}

// Delete a symbol from the table
void delete_symbol(const char* name) {
    unsigned int index = hash(name);
    Symbol* current = hashTable[index];
    Symbol* prev = NULL;

    while (current != NULL && strcmp(current->name, name) != 0) {
        prev = current;
        current = current->next;
    }

    if (current == NULL) {
        printf("Symbol '%s' not found.\n", name);
        return;
    }

    if (prev == NULL) {
        // It's the first element in the list
        hashTable[index] = current->next;
    } else {
        prev->next = current->next;
    }

    free(current->name);
    free(current);
    printf("Deleted '%s' from the symbol table.\n", name);
}

// Display the symbol table
void display() {
    printf("\n--- Symbol Table ---\n");
    for (int i = 0; i < TABLE_SIZE; i++) {
        Symbol* current = hashTable[i];
        if (current != NULL) {
            printf("Index %d: ", i);
            while (current != NULL) {
                printf(" -> %s", current->name);
                current = current->next;
            }
            printf("\n");
        }
    }
    printf("--------------------\n");
}

// Free the entire symbol table
void free_table() {
    for (int i = 0; i < TABLE_SIZE; i++) {
        Symbol* current = hashTable[i];
        while (current != NULL) {
            Symbol* temp = current;
            current = current->next;
            free(temp->name);
            free(temp);
        }
    }
}

void print_menu() {
    printf("\nSymbol Table Operations:\n");
    printf("1. Insert a symbol\n");
    printf("2. Delete a symbol\n");
    printf("3. Display symbol table\n");
    printf("4. Exit\n");
    printf("Enter your choice: ");
}

int main() {
    init_hash_table();
    int choice;
    char name_buffer[100];

    while (1) {
        print_menu();
        if (scanf("%d", &choice) != 1) {
            // Clear invalid input
            while (getchar() != '\n');
            printf("Invalid input. Please enter a number.\n");
            continue;
        }

        switch (choice) {
            case 1:
                printf("Enter symbol name to insert: ");
                scanf("%99s", name_buffer);
                insert(name_buffer);
                break;
            case 2:
                printf("Enter symbol name to delete: ");
                scanf("%99s", name_buffer);
                delete_symbol(name_buffer);
                break;
            case 3:
                display();
                break;
            case 4:
                printf("Exiting...\n");
                free_table();
                return 0;
            default:
                printf("Invalid choice. Please try again.\n");
        }
    }

    return 0;
}
