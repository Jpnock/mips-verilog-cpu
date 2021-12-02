# Expected: 0x5

.text
.globl main
main:
    addiu $v0, $v0, 0x6
    addiu $v0, $v0, 0xFFFF
    jr $zero
