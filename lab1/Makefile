CC=as
LD=ld
CFLAGS=-o
LDFLAGS=-m elf_i386 -lc -dynamic-linker /lib/ld-linux.so.2

all: lab1

lab1.o: lab1.s
	$(CC) $(CFLAGS) lab1.o lab1.s

lab1: lab1.o
	$(LD) $(LDFLAGS) -o lab1 lab1.o

clean:
	rm -f lab1.o lab1