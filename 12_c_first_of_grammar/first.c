#include <stdio.h>
#include <string.h>
#include <ctype.h>

// Global variables
int n_productions;
char productions[10][10];
char first_sets[10][10];
int first_set_counts[10];

// Function prototypes
void find_first(char non_terminal, int index);
void add_to_first_set(int index, char terminal);

int main() {
    int i;
    char choice;
    char non_terminal;

    printf("Enter the number of productions: ");
    scanf("%d", &n_productions);

    printf("Enter the productions (e.g., E->TR, use '@' for epsilon):\n");
    for (i = 0; i < n_productions; i++) {
        scanf("%s", productions[i]);
    }

    // Initialize first set counts
    for (i = 0; i < n_productions; i++) {
        first_set_counts[i] = 0;
    }

    // Calculate First sets for all non-terminals
    for (i = 0; i < n_productions; i++) {
        // Find the non-terminal for the current production
        non_terminal = productions[i][0];
        // Find if we already computed for this non-terminal
        int found = 0;
        for(int k=0; k<i; ++k){
            if(productions[k][0] == non_terminal){
                found = 1;
                break;
            }
        }
        if(!found) {
            find_first(non_terminal, i);
        }
    }

    // Copy results for duplicated non-terminals (like A->a | A->b)
     for (i = 0; i < n_productions; i++) {
        for (int j = 0; j < n_productions; j++) {
            if (productions[i][0] == productions[j][0]) {
                strcpy(first_sets[i], first_sets[j]);
                first_set_counts[i] = first_set_counts[j];
            }
        }
    }


    printf("\nFirst sets:\n");
    for (i = 0; i < n_productions; i++) {
        // Avoid printing duplicates for the same non-terminal
        int already_printed = 0;
        for (int k = 0; k < i; k++) {
            if (productions[i][0] == productions[k][0]) {
                already_printed = 1;
                break;
            }
        }
        if (!already_printed) {
            printf("FIRST(%c) = { ", productions[i][0]);
            for (int j = 0; j < first_set_counts[i]; j++) {
                printf("%c ", first_sets[i][j]);
            }
            printf("}\n");
        }
    }

    return 0;
}

void find_first(char non_terminal, int nt_index) {
    // Iterate through all productions to find rules for the given non_terminal
    for (int i = 0; i < n_productions; i++) {
        if (productions[i][0] == non_terminal) {
            // Case 1: The production starts with a terminal
            if (!isupper(productions[i][3])) {
                add_to_first_set(nt_index, productions[i][3]);
            }
            // Case 2: The production starts with a non-terminal
            else {
                // Recursively find the first of the starting non-terminal
                char next_nt = productions[i][3];
                int next_nt_index = -1;
                 for(int j=0; j<n_productions; ++j){
                    if(productions[j][0] == next_nt){
                        next_nt_index = j;
                        break;
                    }
                }

                if(next_nt_index != -1){
                    // If we haven't computed the first set for this NT yet
                    if(first_set_counts[next_nt_index] == 0){
                        find_first(next_nt, next_nt_index);
                    }

                    // Add the first set of the next NT to our current set
                    int has_epsilon = 0;
                    for(int k=0; k<first_set_counts[next_nt_index]; ++k){
                        if(first_sets[next_nt_index][k] == '@'){
                            has_epsilon = 1;
                        } else {
                            add_to_first_set(nt_index, first_sets[next_nt_index][k]);
                        }
                    }

                    // If the first set of the next NT has epsilon, we need to look further
                    // This simple implementation does not handle the full epsilon case (e.g., X -> Y Z, where Y is epsilon)
                    // It's a common simplification for introductory exercises.
                    if(has_epsilon){
                         // For simplicity, if Y in X->YZ has epsilon, we add epsilon to First(X)
                         // A full implementation would proceed to check Z.
                         add_to_first_set(nt_index, '@');
                    }
                }
            }
        }
    }
}

void add_to_first_set(int index, char terminal) {
    // Check if the terminal is already in the set
    for (int i = 0; i < first_set_counts[index]; i++) {
        if (first_sets[index][i] == terminal) {
            return; // Already exists
        }
    }
    // Add the terminal to the set
    first_sets[index][first_set_counts[index]++] = terminal;
}
