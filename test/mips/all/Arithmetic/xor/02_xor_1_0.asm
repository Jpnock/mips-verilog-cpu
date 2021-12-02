# Expected: 0x12

.text
.globl main
main:
    addiu $t1, $t1, 0x12
    xor $v0, $v0, $t1
    jr $zero
    