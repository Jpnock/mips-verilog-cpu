# Expect: 0xFFFFFFFE

.text
.globl main
main:
    li $t0, 0x80000000
    sra $v0, $t0, 30
    jr $zero
