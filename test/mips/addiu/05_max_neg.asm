# Expect: -65536

.text
.globl main
main:
    addiu $t0, $t0, -0x8000
    addiu $v0, $t0, -0x8000
    jr $zero

