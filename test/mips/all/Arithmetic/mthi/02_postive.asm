# Expected: 0x5

.text
.globl main
main:
    addiu $v0, $v0, 0x5
    mthi $v0
    jr $zero
