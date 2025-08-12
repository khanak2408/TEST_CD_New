#include <iostream>
#include <fstream>
#include <map>

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

    std::map<char, int> char_counts;
    char c;

    // Read file character by character
    while (file.get(c)) {
        char_counts[c]++;
    }

    std::cout << "Character occurrence count in '" << argv[1] << "':" << std::endl;

    for (auto const& [key, val] : char_counts) {
        // Handle special characters that are not easily printable
        if (key == '\n') {
            std::cout << "'\\n'" << ": " << val << std::endl;
        } else if (key == '\t') {
            std::cout << "'\\t'" << ": " << val << std::endl;
        } else if (key == ' ') {
            std::cout << "'space'" << ": " << val << std::endl;
        }
        else {
            std::cout << "'" << key << "': " << val << std::endl;
        }
    }

    return 0;
}
