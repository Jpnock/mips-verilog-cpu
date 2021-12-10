# Expect: 0x12

.text
.globl main
main:
    addiu $t0, $t0, 0x12
    sra $v0, $t0, 0x0
    jr $zero
