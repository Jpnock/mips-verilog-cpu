# Expected: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0xFFFF
    addiu $v0, $v0, 0xFFFF
    xor $v0, $v0, $t1
    jr $zero
    