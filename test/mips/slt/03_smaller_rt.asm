# Expect: 0x00000000

.text
.globl main
main:
    addiu $t0, $t0, 0x5000
    addiu $t1, $t1, 0x8DFF
    slt $v0, $t0, $t1
    jr $zero
