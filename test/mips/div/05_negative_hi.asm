# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, -0xF
    addiu $v0, $t2, -0x5
    div $zero, $t1, $v0
    nop
    nop
    mfhi $v0
    jr $zero
