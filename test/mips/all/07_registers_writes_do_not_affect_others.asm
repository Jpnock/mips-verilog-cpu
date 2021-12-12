# Expect: 0x0

.set noat
.text
.globl main
main:
    or $v0, $v0, $zero
    addiu $zero, $zero, -1

    or $v0, $v0, $at
    addiu $at, $at, -1

    # Can't include v0 in the test as this is being
    # used as the return value.
    or $v0, $v0, $v0
    or $v0, $v0, $v1
    addiu $v1, $v1, -1

    or $v0, $v0, $a0
    addiu $a0, $a0, -1
    or $v0, $v0, $a1
    addiu $a1, $a1, -1
    or $v0, $v0, $a2
    addiu $a2, $a2, -1
    or $v0, $v0, $a3
    addiu $a3, $a3, -1

    or $v0, $v0, $t0
    addiu $t0, $t0, -1
    or $v0, $v0, $t1
    addiu $t1, $t1, -1
    or $v0, $v0, $t2
    addiu $t2, $t2, -1
    or $v0, $v0, $t3
    addiu $t3, $t3, -1
    or $v0, $v0, $t4
    addiu $t4, $t4, -1
    or $v0, $v0, $t5
    addiu $t5, $t5, -1
    or $v0, $v0, $t6
    addiu $t6, $t6, -1
    or $v0, $v0, $t7
    addiu $t7, $t7, -1
    or $v0, $v0, $t8
    addiu $t8, $t8, -1
    or $v0, $v0, $t9
    addiu $t9, $t9, -1

    or $v0, $v0, $s0
    addiu $s0, $s0, -1
    or $v0, $v0, $s1
    addiu $s1, $s1, -1
    or $v0, $v0, $s2
    addiu $s2, $s2, -1
    or $v0, $v0, $s3
    addiu $s3, $s3, -1
    or $v0, $v0, $s4
    addiu $s4, $s4, -1
    or $v0, $v0, $s5
    addiu $s5, $s5, -1
    or $v0, $v0, $s6
    addiu $s6, $s6, -1
    or $v0, $v0, $s7
    addiu $s7, $s7, -1

    or $v0, $v0, $k0
    addiu $k0, $k0, -1
    or $v0, $v0, $k1
    addiu $k1, $k1, -1

    or $v0, $v0, $gp
    addiu $gp, $gp, -1
    or $v0, $v0, $sp
    addiu $sp, $sp, -1
    or $v0, $v0, $fp
    addiu $fp, $fp, -1
    or $v0, $v0, $ra
    addiu $ra, $ra, -1

    jr $zero
