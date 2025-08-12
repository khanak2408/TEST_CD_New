#!/bin/bash

# Create or overwrite the main file
echo "# Compiler Design Lab Programs" > ALL_PROGRAMS.md
echo "" >> ALL_PROGRAMS.md

# --- Cover Page ---
echo "## Prepared by: Jules, AI Software Engineer" >> ALL_PROGRAMS.md
echo "## Date: $(date)" >> ALL_PROGRAMS.md
echo "" >> ALL_PROGRAMS.md
echo "---" >> ALL_PROGRAMS.md
echo "" >> ALL_PROGRAMS.md

# --- Table of Contents ---
echo "## Table of Contents" >> ALL_PROGRAMS.md
echo "1.  [Program 1: Keyword Identifier](#program-1-keyword-identifier)" >> ALL_PROGRAMS.md
echo "2.  [Program 2: Keyword Counter](#program-2-keyword-counter)" >> ALL_PROGRAMS.md
echo "3.  [Program 3: Operator Counter](#program-3-operator-counter)" >> ALL_PROGRAMS.md
echo "4.  [Program 4: Character Occurrence Counter](#program-4-character-occurrence-counter)" >> ALL_PROGRAMS.md
echo "5.  [Program 5: Symbol Table](#program-5-symbol-table)" >> ALL_PROGRAMS.md
echo "6.  [Program 6: LEX Validators](#program-6-lex-validators)" >> ALL_PROGRAMS.md
echo "7.  [Program 7: File Statistics Counter](#program-7-file-statistics-counter-lex)" >> ALL_PROGRAMS.md
echo "8.  [Program 8: Vowel and Consonant Counter](#program-8-vowel-and-consonant-counter-lex)" >> ALL_PROGRAMS.md
echo "9.  [Program 9: YACC Recognizer for a...ab...b](#program-9-yacc-recognizer-for-aaabbb)" >> ALL_PROGRAMS.md
echo "10. [Program 10: YACC Arithmetic Evaluator](#program-10-yacc-arithmetic-evaluator)" >> ALL_PROGRAMS.md
echo "11. [Program 11: YACC Recognizer for a^n b^n c^m d^m](#program-11-yacc-recognizer-for-an-bn-cm-dm)" >> ALL_PROGRAMS.md
echo "12. [Program 12: First of a Grammar](#program-12-c-program-to-find-first-of-any-grammar)" >> ALL_PROGRAMS.md
echo "13. [References](#references)" >> ALL_PROGRAMS.md
echo "" >> ALL_PROGRAMS.md
echo "---" >> ALL_PROGRAMS.md
echo "" >> ALL_PROGRAMS.md

# --- Helper function to append content ---
append_content() {
    local title="$1"
    local doc_file="$2"
    shift 2
    local src_files=("$@")

    echo "## $title" >> ALL_PROGRAMS.md
    echo "" >> ALL_PROGRAMS.md
    cat "$doc_file" >> ALL_PROGRAMS.md
    echo "" >> ALL_PROGRAMS.md

    for src_file in "${src_files[@]}"; do
        local ext="${src_file##*.}"
        local lang=""
        if [ "$ext" = "cpp" ]; then lang="cpp"; fi
        if [ "$ext" = "c" ]; then lang="c"; fi
        if [ "$ext" = "l" ]; then lang="lex"; fi
        if [ "$ext" = "y" ]; then lang="yacc"; fi

        echo "### Source Code: \`$src_file\`" >> ALL_PROGRAMS.md
        echo "\`\`\`$lang" >> ALL_PROGRAMS.md
        cat "$src_file" >> ALL_PROGRAMS.md
        echo "\`\`\`" >> ALL_PROGRAMS.md
        echo "" >> ALL_PROGRAMS.md
    done
    echo "---" >> ALL_PROGRAMS.md
    echo "" >> ALL_PROGRAMS.md
}

# --- Append all programs ---
append_content "Program 1: Keyword Identifier" "1_keyword_identifier/keyword_identifier.md" "1_keyword_identifier/keyword_identifier.cpp"
append_content "Program 2: Keyword Counter" "2_keyword_counter/keyword_counter.md" "2_keyword_counter/keyword_counter.cpp" "2_keyword_counter/keyword_counter.l"
append_content "Program 3: Operator Counter" "3_operator_counter/operator_counter.md" "3_operator_counter/operator_counter.c" "3_operator_counter/operator_counter.l"
append_content "Program 4: Character Occurrence Counter" "4_character_counter/character_counter.md" "4_character_counter/character_counter.cpp"
append_content "Program 5: Symbol Table" "5_symbol_table/symbol_table.md" "5_symbol_table/symbol_table.c"
append_content "Program 6: LEX Validators" "6_lex_validators/validators.md" "6_lex_validators/validators.l"
append_content "Program 7: File Statistics Counter (LEX)" "7_lex_word_counter/counter.md" "7_lex_word_counter/counter.l"
append_content "Program 8: Vowel and Consonant Counter (LEX)" "8_lex_vowel_consonant_counter/counter.md" "8_lex_vowel_consonant_counter/counter.l"
append_content "Program 9: YACC Recognizer for a...ab...b" "9_yacc_a_n_b_n/parser.md" "9_yacc_a_n_b_n/lexer.l" "9_yacc_a_n_b_n/parser.y"
append_content "Program 10: YACC Arithmetic Evaluator" "10_yacc_arithmetic_evaluator/evaluator.md" "10_yacc_arithmetic_evaluator/lexer.l" "10_yacc_arithmetic_evaluator/evaluator.y"
append_content "Program 11: YACC Recognizer for a^n b^n c^m d^m" "11_yacc_a_n_b_n_c_m_d_m/parser.md" "11_yacc_a_n_b_n_c_m_d_m/lexer.l" "11_yacc_a_n_b_n_c_m_d_m/parser.y"
append_content "Program 12: C Program to Find First of any Grammar" "12_c_first_of_grammar/first.md" "12_c_first_of_grammar/first.c"

# --- References ---
echo "## References" >> ALL_PROGRAMS.md
echo "" >> ALL_PROGRAMS.md
echo "*   Aho, A. V., Lam, M. S., Sethi, R., & Ullman, J. D. (2007). *Compilers: Principles, Techniques, and Tools*. Pearson." >> ALL_PROGRAMS.md
echo "*   Levine, J. R. (2009). *flex & bison*. O'Reilly Media." >> ALL_PROGRAMS.md
echo "*   Kernighan, B. W., & Ritchie, D. M. (1988). *The C Programming Language*. Prentice Hall." >> ALL_PROGRAMS.md

echo "Consolidated document created: ALL_PROGRAMS.md"
