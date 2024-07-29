#include "kernel.h"

void kernel_main() {
    const char *str = "Hello, kernel world!";
    char *video_memory = (char*) 0xb8000;
    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07;
    }
}
