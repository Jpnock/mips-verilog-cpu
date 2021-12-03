# Expect: 0x5

.text
.globl main
main:
    addiu $t1, $t1, 0x5
    mtlo $t1
    mflo $v0
    jr $zero
