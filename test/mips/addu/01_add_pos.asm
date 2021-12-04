# Expect: 0xA

.text
.globl main
main:
    addiu $t1, $t1, 0x5
    addu $t0, $t1, $t2
    addu $v0, $t1, $t0
    addu $t2, $t1, $t0
    jr $zero
