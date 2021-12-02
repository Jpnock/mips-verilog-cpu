# Expect: -0x3

.text
.globl main
main:
    addiu $t1, $t1, -0xF  
    addiu $v0, $t2, 0x5
    div $v0, $t1, $v0
    nop
    nop
    mflo $v0
    jr $zero
