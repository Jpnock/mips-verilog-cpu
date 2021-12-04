# Expect: 0x0
    
.text
.globl main
main:    
    addiu $t0, $t0, -0x1
    addiu $t1, $t1, 0x1
    divu $zero, $t0, $t1
    nop
    nop
    mfhi $v0
    jr $zero
