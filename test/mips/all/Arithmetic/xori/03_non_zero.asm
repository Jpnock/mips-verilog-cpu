# Expected: 0x9

.text
.globl main
main:
    addiu $t1, $t1, 0xC
    xori $v0, $t1, 0x5
    jr $zero
    