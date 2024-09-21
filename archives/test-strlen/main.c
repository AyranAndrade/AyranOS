#include <stdio.h>

int getLength(char* value) {
    int count = 0;

    char currentValue = value[0];

    while (currentValue != '\0') {
        count++;
        currentValue = value[count];
    }

    return count;
}

int main() {
    char value[] = "Ayran, hello world from kernel!";
    printf("%i", getLength(value));
}
