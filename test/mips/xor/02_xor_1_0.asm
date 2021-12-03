# Expect: 0x12

.text
.globl main
main:
    addiu $t1, $t1, 0x12
    xor $v0, $t0, $t1
    jr $zero
