# Expected: 0x3

.text
.globl main
main:
    addiu $v0, $v0, 0xF
    addiu $t1, $t1, 0x5
    divu $v0, $t1
    jr $zero
    