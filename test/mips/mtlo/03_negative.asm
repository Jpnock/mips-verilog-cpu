# Expect: -0xAA

.text
.globl main
main:
    addiu $t1, $t1, -0xAA
    mtlo $t1
    mflo $v0
    jr $zero
