# Expect: 0xFFFFFFFE

.text
.globl main
main:
    li $t0, 0x80000000
    li $t1, 30
    srav $v0, $t0, $t1
    jr $zero
