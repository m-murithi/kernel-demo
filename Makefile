CROSS_PREFIX = i686-elf-
CC = $(CROSS_PREFIX)gcc
LD = $(CROSS_PREFIX)ld
AS = nasm

CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -ffreestanding -O2 -nostdlib

BUILD_DIR = build

all: $(BUILD_DIR)/os-image.bin

$(BUILD_DIR)/os-image.bin: $(BUILD_DIR)/boot_sect.bin $(BUILD_DIR)/kernel.bin
    cat $^ > $@

$(BUILD_DIR)/boot_sect.bin: boot/boot.asm
    mkdir -p $(BUILD_DIR)
    $(AS) -f bin $< -o $@

$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/kernel.o $(BUILD_DIR)/kernel.o
    $(LD) -o $@ -T boot/linker.ld $^ --oformat binary

$(BUILD_DIR)/kernel.o: kernel/kernel.asm
    $(AS) -f elf $< -o $@

$(BUILD_DIR)/kernel.o: kernel/kernel.c
    $(CC) $(CFLAGS) -c $< -o $@ -Iinclude

clean:
    rm -rf $(BUILD_DIR)

.PHONY: all clean
