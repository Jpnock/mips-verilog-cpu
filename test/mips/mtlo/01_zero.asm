# Expect: 0x0

.text
.globl main
main:
    mtlo $t1
    mflo $v0
    jr $zero
    