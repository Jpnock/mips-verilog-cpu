# Expect: 0x0

.text
.globl main
main:
    multu $t0, $t1
    nop
    nop
    mflo $v0
    jr $zero
    
