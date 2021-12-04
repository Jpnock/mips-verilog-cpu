# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF
    sll $t1, $t1, 0x10
    addiu $t2, $t2, 0x7FFF
    addu $t2, $t2, $t2
    addiu $t2, $t2, 0x1
    addu $t1, $t1, $t2

    multu $t0, $t1
    nop
    nop
    mflo $v0
    jr $zero

