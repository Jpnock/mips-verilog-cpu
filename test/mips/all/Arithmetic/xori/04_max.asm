# Expected: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0xFFFF
    xori $v0, $t1, 0xFFFF
    jr $zero
    