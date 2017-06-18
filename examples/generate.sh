#!/bin/sh

m4_files=`ls *.m4 | grep -v asm.m4`


generate() {

    for f in $m4_files; do
	base="${f%.*}"
	m4 --define=_SYSTEM=$1 $f | expand >$2/$base.asm
    done
    cp asm_io.* *.c *.cpp *.h *.hpp $2
}

generate linux linux
generate djgpp djgpp
generate djgpp ms
generate bcc borland
generate watcom watcom

# Assemble the asm_io.asm file to create the object file
cd linux
nasm -f elf -d ELF_TYPE asm_io.asm
cd ../djgpp
nasm -f coff -d COFF_TYPE asm_io.asm
cd ../ms
nasm -f win32 -d COFF_TYPE asm_io.asm
cd ../borland
nasm -f obj -d OBJ_TYPE asm_io.asm
cd ../
nasm -f obj -d OBJ_TYPE -d WATCOM asm_io.asm
