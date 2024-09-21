#include "string.h"
#include "screen.h"

void main() {
    char value[] = "Ayran, hello world from kernel!";
    clearScreen();
    print(value);

    while(1) {}
}
