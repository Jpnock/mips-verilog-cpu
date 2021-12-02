# Expect: 0xC

.text
.globl main
main:
    addiu $v0, $v0, 0x8
    addiu $v0, $v0, 0x3
    addiu $v0, $v0, 0x1
    addiu $v0, $v0, 0x0
    jr $zero

