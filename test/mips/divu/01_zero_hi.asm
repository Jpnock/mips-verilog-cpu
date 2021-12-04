# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x5
    divu $zero, $t0, $t1
    nop
    nop
    mfhi $v0
    jr $zero
    