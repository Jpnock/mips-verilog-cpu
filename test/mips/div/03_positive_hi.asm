# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0xF
    addiu $t2, $t2, 0x5
    div $zero, $t1, $t2
    nop
    nop
    mfhi $v0
    jr $zero
