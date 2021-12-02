# Expect: -0x10000

.text
.globl main
main:
    addiu $v0, $v0, -0x8000
    addiu $v0, $v0, -0x8000
    jr $zero

