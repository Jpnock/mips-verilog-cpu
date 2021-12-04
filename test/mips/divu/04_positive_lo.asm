# Expect: 0x3

.text
.globl main
main:
    addiu $t0, $t0, 0xF
    addiu $t1, $t1, 0x5
    divu $zero, $t0, $t1
    nop
    nop
    mflo $v0
    jr $zero
    
