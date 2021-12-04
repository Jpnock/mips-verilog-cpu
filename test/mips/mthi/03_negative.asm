# Expect: -0x5

.text
.globl main
main:
    addiu $t1, $t1, -0x5
    mthi $t1
    mfhi $v0
    jr $zero
