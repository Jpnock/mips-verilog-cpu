# Expect: 0x00000000

.text
.globl main
main:
    addiu $t0, $t0, 0x9999
    addiu $t1, $t1, 0xFFFF
    slti $v0, $t1, 0xFFFF
    jr $zero
