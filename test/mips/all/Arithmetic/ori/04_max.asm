# Expected: 0xFFFF

.text
.globl main
main:
    addiu $t1, $t1, 0xFFFF
    ori $v0, $t1, 0xFFFF
    jr $zero
