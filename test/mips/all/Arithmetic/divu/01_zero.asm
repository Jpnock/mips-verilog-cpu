# Expected: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x5
    divu $v0, $t1
    jr $zero
    