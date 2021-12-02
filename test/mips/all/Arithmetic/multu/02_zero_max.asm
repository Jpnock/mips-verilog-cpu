# Expected: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0xFFFF
    multu $v0, $t1
    jr $zero
    