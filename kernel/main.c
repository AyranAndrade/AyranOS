#include "string.h"

void print(char* value);
void clearScreen();

void main() {
    char value[] = "Ayran, hello world from kernel!";
    clearScreen();
    print(value);

    while(1) {}
}

void print(char* value) {
    char* videoMemory = (char *)0xb8000;

    for (int i = 0; i < getLength(value); i++) {
        videoMemory[i * 2] = value[i];
        videoMemory[i * 2 + 1] = 0x07; 
    }
}

void clearScreen() {
    char* videoMemory = (char *)0xb8000;

    for (int i = 0; i < 80 * 25; i++) {
        videoMemory[i * 2] = ' ';
        videoMemory[i * 2 + 1] = 0x07; 
    }
}