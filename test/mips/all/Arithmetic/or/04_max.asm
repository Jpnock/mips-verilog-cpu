# Expected: 0xFFFF

.text
.globl main
main:
    addiu $t1, $t1, 0xFFFF
    addiu $t2, $t2, 0xFFFF
    or $v0, $t1, $t2
    jr $zero
