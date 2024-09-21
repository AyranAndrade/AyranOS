void main(void) {
    char *video_memory = (char *)0xb8000;
    video_memory[0] = 'A';
    video_memory[1] = 0x07;
    video_memory[2] = 'Y';
    video_memory[3] = 0x07;
    video_memory[4] = 'R';
    video_memory[5] = 0x07;
    video_memory[6] = 'A';
    video_memory[7] = 0x07;
    video_memory[8] = 'N';

    while(1) {}  
}