# Expect: 0x0

.text
.globl main
main:
    addiu $v0, $v0, 0xF
    addiu $t1, $t1, 0x5
    divu $zero, $v0, $t1
    nop
    nop
    mfhi $v0
    jr $zero
    