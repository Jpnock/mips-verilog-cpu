# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x4
    div $zero, $v0, $t1
    nop
    nop
    mfhi $v0
    jr $zero
