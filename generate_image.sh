#!/bin/sh
if [ $# -ne 1 ]
then
    echo "Missing params"
    exit 1
fi
as -o "$1.o" $1
ld --Ttext 0x0000 --oformat=binary "$1.o" -o "$1".bin
dd if=/dev/zero of=floppy.img bs=512 count=2880
dd if="$1.bin" of=floppy.img
