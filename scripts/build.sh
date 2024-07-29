#!/bin/bash

set -e

# Variables
CROSS_PREFIX="i686-elf-"
CC="${CROSS_PREFIX}gcc"
LD="${CROSS_PREFIX}ld"
AS=nasm

# Directories
BUILD_DIR=build
BOOT_DIR=boot
KERNEL_DIR=kernel
INCLUDE_DIR=include

# Clean build directory
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}

# Assemble boot sector
${AS} -f bin ${BOOT_DIR}/boot.asm -o ${BUILD_DIR}/boot_sect.bin

# Assemble kernel entry
${AS} -f elf ${KERNEL_DIR}/kernel.asm -o ${BUILD_DIR}/kernel.o

# Compile kernel
${CC} -std=gnu99 -ffreestanding -O2 -Wall -Wextra -c ${KERNEL_DIR}/kernel.c -o ${BUILD_DIR}/kernel.o -I${INCLUDE_DIR}

# Link kernel
${LD} -o ${BUILD_DIR}/kernel.bin -T ${BOOT_DIR}/linker.ld ${BUILD_DIR}/kernel.o ${BUILD_DIR}/kernel.o --oformat binary

# Create OS image
cat ${BUILD_DIR}/boot_sect.bin ${BUILD_DIR}/kernel.bin > ${BUILD_DIR}/os-image.bin

echo "Build successful. Bootable image is located at ${BUILD_DIR}/os-image.bin"
