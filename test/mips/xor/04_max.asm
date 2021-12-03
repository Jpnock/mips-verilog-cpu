# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF
    addiu $t0, $t0, 0x7FFF
    xor $v0, $t0, $t1
    jr $zero
