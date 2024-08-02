# kernel-demo
This project demonstrates the creation of a basic operating system kernel. It includes the setup of a bootloader and a simple kernel written in C and assembly.


### Project Structure
---

```plaintext
kernel-demo/
├── boot/
│   ├── boot.asm
│   └── linker.ld
├── build/
├── include/
│   └── kernel.h
├── kernel/
│   ├── kernel_entry.asm
│   └── kernel.c
├── scripts/
│   └── build.sh
├── Makefile
└── README.md
```

### Building the project
---

```bash
./scripts/build.sh
```

