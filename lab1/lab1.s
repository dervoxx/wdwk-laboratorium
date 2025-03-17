.section .data
    fmt:    .asciz "%d\n"  # Format dla printf
    in_fmt: .asciz "%d"    # Format dla scanf
    n:      .int 0         # Zmienna n, początkowa wartość 0
    err_msg: .asciz "Niepoprawne dane wejściowe!\n"
    ovf_msg: .asciz "Przekroczono zakres! \n"

.section .text
    .globl _start
_start:
    # Przygotowanie do wywołania scanf
    lea in_fmt, %ebx       # Załaduj adres fmt dla scanf do %ebx
    lea n, %ecx            # Załaduj adres zmiennej n do %ecx
    push %ecx              # Argument 1: adres zmiennej n
    push %ebx              # Argument 2: adres fmt
    call scanf             # Wywołanie funkcji scanf

    # Sprawdzenie czy scanf poprawnie wczytał
    cmp $1, %eax           # Jezeli wczytał poprawnie zwróci 1
    jne invalid_input      # if %eax != 1


    # Ładujemy wartość zmiennej n do rejestru %eax
    movl n, %eax           # eax = n
    imul %eax, %eax        # eax = n^2
    jo overflow_error      # sprawdzenie czy występuje overflow
    movl %eax, %ecx        # ecx = n^2
    movl n, %ebx           # ebx = n
    imul %ebx, %eax        # eax = ebx * eax = n * n^2 = n^3
    jo overflow_error      # sprawdzenie czy występuje overflow

    movl $3, %ebx          # ebx = 3
    imul %ecx, %ebx        # ebx = n^2 * 3
    add %ebx, %eax         # eax = n^3 + 3n^2
    jo overflow_error      # sprawdzenie czy występuje overflow

    movl $2, %ebx          # ebx = 2
    movl n, %ecx           # ecx = n
    imul %ecx, %ebx        # ebx = 2n
    sub %ebx, %eax         # eax = n^3 + 3n^2 - 2n

    # Przygotowanie do wywołania printf
    lea fmt, %ebx          # fmt (format) do %ebx
    push %eax              # n (w %eax) jako drugi argument stosu
    push %ebx              # fmt jako pierwszy argument stosu
    call printf

    # Zakończenie programu
    movl $1, %eax          # System call number dla _exit (1)
    movl $0, %ebx          # Exit code 0
    int $0x80              # Wywołanie systemowe (exit)

# Zły input
invalid_input:
    lea err_msg, %ebx
    push %ebx              # err_msg jako argument
    call puts              # wypisanie msg
    add $4, %esp           # wyczyszczenie stosu (1 argument = 4 bajty)
    movl $1, %eax          # System call number dla _exit (1)
    movl $1, %ebx          # Exit code 1
    int $0x80              # Wywołanie systemowe (exit)

# Przepełnienie
overflow_error:
    lea ovf_msg, %ebx
    push %ebx              # ovf_msg jako argument
    call puts              # wypisanie msg
    add $4, %esp           # wyczyszczenie stosu (1 argument = 4 bajty)
    movl $1, %eax          # System call number dla _exit (1)
    movl $2, %ebx          # Exit code 2
    int $0x80              # Wywołanie systemowe (exit)