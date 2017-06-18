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



    
