# Expect: 0x0

.text
.globl main
main:
    mthi $t1
    mfhi $v0
    jr $zero
