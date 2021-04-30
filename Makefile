all: build run

build:
	nasm -f elf32 boot.asm -o boot.o
	gcc -m32 -fno-pie  kmain.c boot.o -o kernel.bin\
	       	-nostdlib -ffreestanding -std=c99 -mno-red-zone\
	       	-fno-exceptions -nostdlib -Wall -Wextra -Werror -T linker.ld

run:
	qemu-system-x86_64 -fda kernel.bin
