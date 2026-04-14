.section .rodata
filename:   .string "input.txt"
str_yes:    .string "Yes\n"
str_no:     .string "No\n"

.text
.globl main
main:
    addi    sp, sp, -64
    sd      ra, 48(sp)
    sd      s0, 40(sp)
    sd      s1, 32(sp)
    sd      s2, 24(sp)
    sd      s3, 16(sp)

    la      a0, filename
    li      a1, 0
    li      a2, 0
    call    open
    mv      s0, a0

    mv      a0, s0
    li      a1, 0
    li      a2, 2
    call    lseek
    mv      s1, a0

    li      t0, 1
    ble     s1, t0, .yes_palindrome

    li      s2, 0
    addi    s3, s1, -1

.check_loop:
    bge     s2, s3, .yes_palindrome

    mv      a0, s0
    mv      a1, s2
    li      a2, 0
    call    lseek

    mv      a0, s0
    mv      a1, sp
    li      a2, 1
    call    read

    mv      a0, s0
    mv      a1, s3
    li      a2, 0
    call    lseek

    mv      a0, s0
    addi    a1, sp, 8
    li      a2, 1
    call    read

    lbu     t0, 0(sp)
    lbu     t1, 8(sp)
    bne     t0, t1, .no_palindrome

    addi    s2, s2, 1
    addi    s3, s3, -1
    j       .check_loop

.yes_palindrome:
    la      a0, str_yes
    call    printf
    j       .q5_close

.no_palindrome:
    la      a0, str_no
    call    printf

.q5_close:
    mv      a0, s0
    call    close
    li      a0, 0
    ld      ra, 48(sp)
    ld      s0, 40(sp)
    ld      s1, 32(sp)
    ld      s2, 24(sp)
    ld      s3, 16(sp)
    addi    sp, sp, 64
    ret
