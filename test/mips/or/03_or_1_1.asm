# Expect: 0x1D

.text
.globl main
main:
    addiu $t1, $t1, 0x15
    addiu $t2, $t2, 0x1D
    or $v0, $t1, $t2
    jr $zero
