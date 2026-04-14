.section .rodata
fmt_int:    .string "%d"
fmt_sp_int: .string " %d"
fmt_nl:     .string "\n"

.text
.global main
main:
    addi    sp, sp, -64
    sd      ra, 56(sp)
    sd      s0, 48(sp)
    sd      s1, 40(sp)
    sd      s2, 32(sp)
    sd      s3, 24(sp)
    sd      s4, 16(sp)
    sd      s5, 8(sp)
    sd      s6, 0(sp)

    mv      s0, a0
    mv      s1, a1
    addi    s2, s0, -1

    beqz    s2, .q2_exit

    slli    a0, s2, 2
    call    malloc
    mv      s3, a0

    slli    a0, s2, 2
    call    malloc
    mv      s4, a0

    slli    a0, s2, 2
    call    malloc
    mv      s5, a0

    li      s6, 0

.init_loop:
    bge     s6, s2, .parse
    slli    t1, s6, 2
    add     t1, s4, t1
    li      t2, -1
    sw      t2, 0(t1)
    addi    s6, s6, 1
    j       .init_loop

.parse:
    li      s6, 0
.parse_loop:
    bge     s6, s2, .algo
    addi    t1, s6, 1
    slli    t2, t1, 3
    add     t2, s1, t2
    ld      a0, 0(t2)
    call    atoi
    slli    t2, s6, 2
    add     t2, s3, t2
    sw      a0, 0(t2)
    addi    s6, s6, 1
    j       .parse_loop


.algo:
    li      s6, 0
    addi    t0, s2, -1
.algo_loop:
    bltz    t0, .print_results
    slli    t1, t0, 2
    add     t1, s3, t1
    lw      t1, 0(t1)
.while_pop:
    beqz    s6, .while_done
    addi    t2, s6, -1
    slli    t3, t2, 2
    add     t3, s5, t3
    lw      t3, 0(t3)
    slli    t4, t3, 2
    add     t4, s3, t4
    lw      t4, 0(t4)
    bgt     t4, t1, .while_done
    addi    s6, s6, -1
    j       .while_pop
.while_done:
    beqz    s6, .do_push
    addi    t2, s6, -1
    slli    t3, t2, 2
    add     t3, s5, t3
    lw      t3, 0(t3)
    slli    t4, t0, 2
    add     t4, s4, t4
    sw      t3, 0(t4)
.do_push:
    slli    t2, s6, 2
    add     t2, s5, t2
    sw      t0, 0(t2)
    addi    s6, s6, 1
    addi    t0, t0, -1
    j       .algo_loop

.print_results:
    li      s6, 0
.print_loop:
    bge     s6, s2, .print_nl
    slli    t1, s6, 2
    add     t1, s4, t1
    lw      a1, 0(t1)
    beqz    s6, .first_fmt
    la      a0, fmt_sp_int
    j       .do_printf
.first_fmt:
    la      a0, fmt_int
.do_printf:
    call    printf
    addi    s6, s6, 1
    j       .print_loop
.print_nl:
    la      a0, fmt_nl
    call    printf

.q2_exit:
    li      a0, 0
    ld      ra, 56(sp)
    ld      s0, 48(sp)
    ld      s1, 40(sp)
    ld      s2, 32(sp)
    ld      s3, 24(sp)
    ld      s4, 16(sp)
    ld      s5, 8(sp)
    ld      s6, 0(sp)
    addi    sp, sp, 64
    ret
