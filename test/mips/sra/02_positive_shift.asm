# Expect: 0x5

.text
.globl main
main:
    addiu $t0, $t0, 0x1500
    sra $v0, $t0, 0xA
    jr $zero
