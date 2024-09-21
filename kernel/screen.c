#include "screen.h"
#include "string.h"
#include "constants.h"

void print(char* value) {
    for (int i = 0; i < getLength(value); i++) {
        VIDEO_MEMORY[i * 2] = value[i];
        VIDEO_MEMORY[i * 2 + 1] = WHITE; 
    }
}

void clearScreen() {
    for (int i = 0; i < NUMBER_OF_CHARACTERS; i++) {
        VIDEO_MEMORY[i * 2] = ' ';
        VIDEO_MEMORY[i * 2 + 1] = WHITE; 
    }
}