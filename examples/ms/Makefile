#
# Microsoft makefile
# Use with nmake
#

.SUFFIXES:
.SUFFIXES: .obj .asm .cpp .c

AS=nasm
ASFLAGS= -f win32
CFLAGS=
CC=cl
CXX=cl
CXXFLAGS=-GX

.asm.obj:
	$(AS) $(ASFLAGS) $*.asm

.cpp.obj:
	$(CXX) -c $(CXXFLAGS) $*.cpp

.c.obj:
	$(CC) -c $(CFLAGS) $*.c

all: prime.exe math.exe sub1.exe sub2.exe sub3.exe sub4.exe sub5.exe sub6.exe first.exe memex.exe dmaxt.exe asm_io.obj fprime.exe quadt.exe test_big_int.exe

prime.exe: driver.obj prime.obj asm_io.obj
	$(CC) $(CFLAGS) -Feprime.exe driver.obj prime.obj asm_io.obj

math.exe : driver.obj math.obj asm_io.obj
	$(CC) $(CFLAGS) -Femath.exe driver.obj math.obj asm_io.obj

first.exe : driver.obj first.obj asm_io.obj
	$(CC) $(CFLAGS) -Fefirst.exe driver.obj first.obj asm_io.obj

sub1.exe : driver.obj sub1.obj asm_io.obj
	$(CC) $(CFLAGS) -Fesub1.exe driver.obj sub1.obj asm_io.obj

sub2.exe : driver.obj sub2.obj asm_io.obj
	$(CC) $(CFLAGS) -Fesub2.exe driver.obj sub2.obj asm_io.obj

sub3.exe : driver.obj sub3.obj asm_io.obj
	$(CC) $(CFLAGS) -Fesub3.exe driver.obj sub3.obj asm_io.obj

sub4.exe : driver.obj sub4.obj main4.obj asm_io.obj
	$(CC) $(CFLAGS) -Fesub4.exe driver.obj sub4.obj main4.obj asm_io.obj

sub5.exe :	main5.obj sub5.obj asm_io.obj
	$(CC) $(CFLAGS) -Fesub5.exe main5.obj sub5.obj asm_io.obj

sub6.exe :	main6.obj sub6.obj
	$(CC) $(CFLAGS) -Fesub6.exe main6.obj sub6.obj

asm_io.obj : asm_io.asm
	$(AS) $(ASFLAGS) -d COFF_TYPE asm_io.asm

array1.exe : driver.obj array1.obj array1c.obj
	$(CC) $(CFLAGS) -Fearray1.exe array1.obj array1c.obj asm_io.obj

memex.exe : memex.obj memory.obj
	$(CC) $(CFLAGS) -Fememex.exe memex.obj memory.obj

dmaxt.exe : dmaxt.obj dmax.obj
	$(CC) $(CFLAGS) -Fedmaxt.exe dmaxt.obj dmax.obj

quadt.exe : quadt.obj quad.obj
	$(CC) $(CFLAGS) -Fequadt.exe quadt.obj quad.obj

readt.exe : readt.obj read.obj
	$(CC) $(CFLAGS) -Fereadt.exe readt.obj read.obj

fprime.exe : fprime.obj prime2.obj
	$(CC) $(CFLAGS) -Fefprime.exe fprime.obj prime2.obj

test_big_int.exe : test_big_int.obj big_int.obj big_math.obj
	$(CXX) $(CXXFLAGS) -Fetest_big_int.exe test_big_int.obj big_int.obj big_math.obj

big_int.obj : big_int.hpp big_int.cpp

test_big_int.obj : big_int.hpp test_big_int.cpp

first.obj : asm_io.inc first.asm

sub1.obj : asm_io.inc

sub2.obj : asm_io.inc

sub3.obj : asm_io.inc

sub4.obj : asm_io.inc

main4.obj : asm_io.inc

driver.obj : driver.c


clean :
	del *.obj