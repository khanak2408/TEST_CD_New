#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

// List of C++ keywords
std::vector<std::string> keywords = {
    "alignas", "alignof", "and", "and_eq", "asm", "auto", "bitand", "bitor", "bool", "break", "case", "catch", "char", "char8_t", "char16_t", "char32_t", "class", "compl", "concept", "const", "consteval", "constexpr", "constinit", "const_cast", "continue", "co_await", "co_return", "co_yield", "decltype", "default", "delete", "do", "double", "dynamic_cast", "else", "enum", "explicit", "export", "extern", "false", "float", "for", "friend", "goto", "if", "inline", "int", "long", "mutable", "namespace", "new", "noexcept", "not", "not_eq", "nullptr", "operator", "or", "or_eq", "private", "protected", "public", "reflexpr", "register", "reinterpret_cast", "requires", "return", "short", "signed", "sizeof", "static", "static_assert", "static_cast", "struct", "switch", "synchronized", "template", "this", "thread_local", "throw", "true", "try", "typedef", "typeid", "typename", "union", "unsigned", "using", "virtual", "void", "volatile", "wchar_t", "while", "xor", "xor_eq"
};

// Function to check if a given string is a keyword
bool isKeyword(const std::string& word) {
    return std::find(keywords.begin(), keywords.end(), word) != keywords.end();
}

int main() {
    std::string input;
    std::cout << "Enter a string to check if it is a keyword: ";
    std::cin >> input;

    if (isKeyword(input)) {
        std::cout << "'" << input << "' is a keyword." << std::endl;
    } else {
        std::cout << "'" << input << "' is not a keyword." << std::endl;
    }

    return 0;
}
