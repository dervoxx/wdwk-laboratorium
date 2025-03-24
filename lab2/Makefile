AS = as
CC = gcc
LD = gcc
CFLAGS = -m32 -Wall -g
LDFLAGS = -m32 -no-pie

all: lab2

lab2: quicksort.o main.o
	$(LD) $(LDFLAGS) -o lab2 main.o quicksort.o

quicksort.o: quicksort.c
	$(CC) $(CFLAGS) -c quicksort.c -o quicksort.o

main.o: main.s
	$(AS) -32 main.s -o main.o

clean:
	rm -f *.o lab2
