int getLength(char* value);
void print(char* value);

void main() {
    char value[] = "Ayran, hello world from kernel!";
    print(value);

    while(1) {}
}

int getLength(char* value) {
    int count = 0;

    char currentValue = value[0];

    while (currentValue != '\0') {
        count++;
        currentValue = value[count];
    }

    return count;
}

void print(char* value) {
    char* videoMemory = (char *)0xb8000;

    for (int i = 0; i < getLength(value); i++) {
        videoMemory[i * 2] = value[i];
        videoMemory[i * 2 + 1] = 0x07; 
    }
}