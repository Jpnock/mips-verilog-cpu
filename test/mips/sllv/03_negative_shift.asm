# Expect: -0x5400

.text
.globl main
main:
    addiu $t0, $t0, -0x15
    addiu $t1, $t1, 0xA
    sllv $v0, $t0, $t1
    jr $zero
