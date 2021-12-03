# Expect: 0x7FFF

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF 
    mthi $t1
    mfhi $v0
    jr $zero
