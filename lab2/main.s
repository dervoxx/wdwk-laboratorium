.global main
.extern quicksort
.extern isSorted
.extern printf
.section .text
main:
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp        # Rezerwacja miejsca na zmienne lokalne

    # Odczyt znacznika czasu przed quicksort
    rdtsc
    movl %eax, -4(%ebp)  # Zapis dolnych 32 bitów
    movl %edx, -8(%ebp)  # Zapis górnych 32 bitów

    # Wywołanie quicksort
    pushl $7
    pushl $0
    pushl $array
    call quicksort
    addl $12, %esp

    # Odczyt znacznika czasu po quicksort
    rdtsc

    # Obliczenie różnicy
    subl -4(%ebp), %eax  # Odejmowanie dolnych 32 bitów
    sbbl -8(%ebp), %edx  # Odejmowanie górnych 32 bitów z pożyczką

    # Teraz %edx:%eax zawiera liczbę cykli CPU
    # Przygotowanie do wywołania printf
    pushl %edx           # Przekazanie górnych 32 bitów
    pushl %eax           # Przekazanie dolnych 32 bitów
    pushl $format        # Przekazanie formatu
    call printf
    addl $12, %esp

    # Zakończenie programu
    movl $0, %eax
    leave
    ret

.section .data
array:
    .long 5, 3, 5, 7, 5, 8, 5, 2, 5, 9

format:
    .asciz "Quicksort zajął %u%u cykli CPU\n"
