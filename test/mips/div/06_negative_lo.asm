# Expect: 0x3

.text
.globl main
main:
    addiu $t1, $t1, -0xF
    addiu $t2, $t2, -0x05
    div $zero, $t1, $t2
    nop
    nop
    mflo $v0
    jr $zero
