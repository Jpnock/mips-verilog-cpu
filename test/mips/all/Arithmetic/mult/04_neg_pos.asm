# Expected: 0xFFE7

.text
.globl main
main:
    addiu $v0, $v0, 0x5
    addiu $t1, $t1, 0xFFFB
    mult $v0, $t1
    jr $zero
    