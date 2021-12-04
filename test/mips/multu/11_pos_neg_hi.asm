# Expect: 0x4

.text
.globl main
main:
    addiu $t0, $t0, -0x5
    addiu $t1, $t1, 0x5
    multu $t0, $t1
    nop
    nop
    mfhi $v0
    jr $zero
    
