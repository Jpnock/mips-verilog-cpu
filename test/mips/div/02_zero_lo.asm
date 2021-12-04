# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x4
    div $zero, $t0, $t1
    nop
    nop
    mflo $v0
    jr $zero
