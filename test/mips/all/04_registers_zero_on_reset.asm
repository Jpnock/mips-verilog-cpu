# Expect: 0x0

.set noat
.text
.globl main
main:
    or $v0, $v0, $zero

    or $v0, $v0, $at

    or $v0, $v0, $v0
    or $v0, $v0, $v1

    or $v0, $v0, $a0
    or $v0, $v0, $a1
    or $v0, $v0, $a2
    or $v0, $v0, $a3

    or $v0, $v0, $t0
    or $v0, $v0, $t1
    or $v0, $v0, $t2
    or $v0, $v0, $t3
    or $v0, $v0, $t4
    or $v0, $v0, $t5
    or $v0, $v0, $t6
    or $v0, $v0, $t7
    or $v0, $v0, $t8
    or $v0, $v0, $t9

    or $v0, $v0, $s0
    or $v0, $v0, $s1
    or $v0, $v0, $s2
    or $v0, $v0, $s3
    or $v0, $v0, $s4
    or $v0, $v0, $s5
    or $v0, $v0, $s6
    or $v0, $v0, $s7

    or $v0, $v0, $k0
    or $v0, $v0, $k1

    or $v0, $v0, $gp
    or $v0, $v0, $sp
    or $v0, $v0, $fp
    or $v0, $v0, $ra

    jr $zero
