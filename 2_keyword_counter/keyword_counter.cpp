#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <sstream>

// List of C++ keywords
std::vector<std::string> keywords = {
    "alignas", "alignof", "and", "and_eq", "asm", "auto", "bitand", "bitor", "bool", "break", "case", "catch", "char", "char8_t", "char16_t", "char32_t", "class", "compl", "concept", "const", "consteval", "constexpr", "constinit", "const_cast", "continue", "co_await", "co_return", "co_yield", "decltype", "default", "delete", "do", "double", "dynamic_cast", "else", "enum", "explicit", "export", "extern", "false", "float", "for", "friend", "goto", "if", "inline", "int", "long", "mutable", "namespace", "new", "noexcept", "not", "not_eq", "nullptr", "operator", "or", "or_eq", "private", "protected", "public", "reflexpr", "register", "reinterpret_cast", "requires", "return", "short", "signed", "sizeof", "static", "static_assert", "static_cast", "struct", "switch", "synchronized", "template", "this", "thread_local", "throw", "true", "try", "typedef", "typeid", "typename", "union", "unsigned", "using", "virtual", "void", "volatile", "wchar_t", "while", "xor", "xor_eq"
};

// Function to check if a given string is a keyword
bool isKeyword(const std::string& word) {
    return std::find(keywords.begin(), keywords.end(), word) != keywords.end();
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
        return 1;
    }

    std::ifstream file(argv[1]);
    if (!file.is_open()) {
        std::cerr << "Error: Could not open file '" << argv[1] << "'" << std::endl;
        return 1;
    }

    std::string word;
    int keywordCount = 0;

    // Read file word by word
    while (file >> word) {
        // A simple way to handle punctuation attached to words.
        // This is not a perfect parser, but it handles common cases.
        std::string clean_word;
        for (char ch : word) {
            if (isalnum(ch) || ch == '_') {
                clean_word += ch;
            }
        }

        if (isKeyword(clean_word)) {
            keywordCount++;
        }
    }

    std::cout << "Total number of keywords in '" << argv[1] << "': " << keywordCount << std::endl;

    return 0;
}
