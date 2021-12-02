# Expected: 0x15

.text
.globl main
main:
    addiu $t1, $t1, 0x15
    or $v0, $v0, $t1
    jr $zero
    