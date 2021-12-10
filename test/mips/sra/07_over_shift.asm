# Expect: 0x0

.text
.globl main
main:
    addiu $t0, $t0, 0x7FFF
    sra $v0, $t0, 0x1F
    jr $zero
