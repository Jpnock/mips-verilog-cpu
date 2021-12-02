# Expect: 0x34

.text
.globl main
main:
    addiu $t1, $t1, 0x2D
    addiu $v0, $v0, 0x19
    xor $v0, $v0, $t1
    jr $zero
