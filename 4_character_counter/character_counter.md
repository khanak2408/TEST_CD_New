# Program 4: Character Occurrence Counter

This program counts the total occurrence of each character in a given file.

## Logic

1.  **Data Structure**: A `std::map<char, int>` named `char_counts` is used to store the frequency of each character. The `char` is the key, and the `int` is its count. A map is used because it's flexible and only stores entries for characters that actually appear in the file.

2.  **File Input**: The program takes a single command-line argument: the path to the file that needs to be analyzed.

3.  **Character Reading**: It opens the file and reads it character by character using `file.get(c)`. This loop continues until the end of the file.

4.  **Counting**: For each character `c` that is read, its count in the map is incremented: `char_counts[c]++`. If the character is not yet in the map, it is automatically inserted with a default value of 0 before being incremented to 1.

5.  **Output**:
    *   After the entire file has been read, the program iterates through the `char_counts` map.
    *   For each key-value pair, it prints the character and its corresponding count.
    *   Special handling is included for non-printable characters like newline (`\n`) and tab (`\t`) to make the output more readable.

## How to Compile and Run

1.  **Compile the program:**
    You will need a C++ compiler like `g++`.
    ```bash
    g++ character_counter.cpp -o character_counter
    ```

2.  **Run the executable:**
    Provide the path to a text file as an argument.
    ```bash
    ./character_counter <your_file.txt>
    ```

### Example

If `your_file.txt` contains:
```
Hello world!
```

The output will be:
```
Character occurrence count in 'your_file.txt':
' ': 1
'!': 1
'H': 1
'd': 1
'e': 1
'l': 3
'o': 2
'r': 1
'w': 1
'\n': 1
```
*(Note: The order of output may vary as `std::map` sorts keys, and the exact output depends on the character encoding of the file.)*
