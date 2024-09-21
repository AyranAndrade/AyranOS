#include "string.h"

int getLength(char* value) {
    int count = 0;

    char currentValue = value[0];

    while (currentValue != '\0') {
        count++;
        currentValue = value[count];
    }

    return count;
}