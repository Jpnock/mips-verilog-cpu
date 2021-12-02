# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF
    addiu $v0, $v0, 0x7FFF
    xor $v0, $v0, $t1
    jr $zero
