#
# Watcom makefile
# Use with wmake using the -ms switch
#

.SUFFIXES:
.SUFFIXES: .obj .asm .cpp .c

AS=nasm
ASFLAGS= -f obj
CFLAGS= -fpi87
CC=wcl386
CXX=wcl386
CXXFLAGS=-xs -fpi87

.asm.obj:
	$(AS) $(ASFLAGS) $*.asm

.cpp.obj:
	$(CXX) -c $(CXXFLAGS) $*.cpp

.c.obj:
	$(CC) -c $(CFLAGS) $*.c

all: prime.exe math.exe sub1.exe sub2.exe sub3.exe sub4.exe sub5.exe sub6.exe first.exe memex.exe dmaxt.exe asm_io.obj fprime.exe quadt.exe test_big_int.exe

prime.exe: driver.obj prime.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=prime.exe driver.obj prime.obj asm_io.obj

math.exe : driver.obj math.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=math.exe driver.obj math.obj asm_io.obj

first.exe : driver.obj first.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=first.exe driver.obj first.obj asm_io.obj

sub1.exe : driver.obj sub1.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=sub1.exe driver.obj sub1.obj asm_io.obj

sub2.exe : driver.obj sub2.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=sub2.exe driver.obj sub2.obj asm_io.obj

sub3.exe : driver.obj sub3.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=sub3.exe driver.obj sub3.obj asm_io.obj

sub4.exe : driver.obj sub4.obj main4.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=sub4.exe driver.obj sub4.obj main4.obj asm_io.obj

sub5.exe :	main5.obj sub5.obj asm_io.obj
	$(CC) $(CFLAGS) -fe=sub5.exe main5.obj sub5.obj asm_io.obj

sub6.exe :	main6.obj sub6.obj
	$(CC) $(CFLAGS) -fe=sub6.exe main6.obj sub6.obj

asm_io.obj : asm_io.asm
	$(AS) $(ASFLAGS) -d OBJ_TYPE -d WATCOM asm_io.asm

array1.exe : driver.obj array1.obj array1c.obj
	$(CC) $(CFLAGS) -fe=array1.exe array1.obj array1c.obj asm_io.obj

memex.exe : memex.obj memory.obj
	$(CC) $(CFLAGS) -fe=memex.exe memex.obj memory.obj

dmaxt.exe : dmaxt.obj dmax.obj
	$(CC) $(CFLAGS) -fe=dmaxt.exe dmaxt.obj dmax.obj

quadt.exe : quadt.obj quad.obj
	$(CC) $(CFLAGS) -fe=quadt.exe quadt.obj quad.obj

readt.exe : readt.obj read.obj
	$(CC) $(CFLAGS) -fe=readt.exe readt.obj read.obj

fprime.exe : fprime.obj prime2.obj
	$(CC) $(CFLAGS) -fe=fprime.exe fprime.obj prime2.obj

test_big_int.exe : test_big_int.obj big_int.obj big_math.obj
	$(CXX) $(CXXFLAGS) -fe=test_big_int.exe test_big_int.obj big_int.obj big_math.obj

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