# Expected: 0x2F

.text
.globl main
main:
    addiu $t1, $t1, 0xB
    ori $v0, $t1, 0x2F
    jr $zero
