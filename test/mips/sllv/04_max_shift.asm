# Expect: 0x80000000

.text
.globl main
main:
    addiu $t0, $t0, 0x1F
    addiu $t1, $t1, 0x1F
    sllv $v0, $t0, $t1
    jr $zero

