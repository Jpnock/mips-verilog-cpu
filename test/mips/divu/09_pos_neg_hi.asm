# Expect: 0x0

.text
.globl main
main:
    addiu $v0, $v0, 0x1
    addiu $t1, $t1, -0x1
    divu $zero, $v0, $t1
    nop
    nop
    mfhi $v0
    jr $zero
