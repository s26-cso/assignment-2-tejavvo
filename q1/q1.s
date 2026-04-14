.text 

.global make_node
make_node:
    addi    sp, sp, -16
    sd      ra, 8(sp)
    sd      s0, 0(sp)
    mv      s0, a0
    li      a0, 24
    call    malloc
    sw      s0, 0(a0)
    sd      zero, 8(a0)
    sd      zero, 16(a0)
    ld      ra, 8(sp)
    ld      s0, 0(sp)
    addi    sp, sp, 16
    ret

.global insert
insert:
    addi    sp, sp, -32
    sd      ra, 24(sp)
    sd      s0, 16(sp)
    sd      s1, 8(sp)
    mv      s0, a0
    mv      s1, a1
    bnez    s0, .insert_notempty
    mv      a0, s1
    call    make_node
    j       .insert_done

.insert_notempty:
    lw      t0, 0(s0)
    bge     s1, t0, .insert_right
    ld      a0, 8(s0)
    mv      a1, s1
    call    insert
    sd      a0, 8(s0)
    j       .insert_ret_root

.insert_right:
    beq     s1, t0, .insert_ret_root
    ld      a0, 16(s0)
    mv      a1, s1
    call    insert
    sd      a0, 16(s0)

.insert_ret_root:
    mv      a0, s0

.insert_done:
    ld      ra, 24(sp)
    ld      s0, 16(sp)
    ld      s1, 8(sp)
    addi    sp, sp, 32
    ret

.global get
get:
    beqz    a0, .get_null
    lw      t0, 0(a0)
    beq     a1, t0, .get_found
    blt     a1, t0, .get_left
    ld      a0, 16(a0)
    j       get

.get_left:
    ld      a0, 8(a0)
    j       get

.get_found:
    ret

.get_null:
    li      a0, 0
    ret

.global getAtMost
getAtMost:
    addi    sp, sp, -32
    sd      ra, 24(sp)
    sd      s0, 16(sp)
    sd      s1, 8(sp)
    sd      s2, 0(sp)
    mv      s0, a0
    mv      s1, a1
    li      s2, -1
.gam_loop:
    beqz    s1, .gam_done
    lw      t0, 0(s1)
    bgt     t0, s0, .gam_go_left
    mv      s2, t0
    ld      s1, 16(s1)
    j       .gam_loop
.gam_go_left:
    ld      s1, 8(s1)
    j       .gam_loop
.gam_done:
    mv      a0, s2
    ld      ra, 24(sp)
    ld      s0, 16(sp)
    ld      s1, 8(sp)
    ld      s2, 0(sp)
    addi    sp, sp, 32
    ret
