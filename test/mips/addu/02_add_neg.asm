# Expect: -0x51

.text
.globl main
main:
    addiu $t1, $t1, -0x6 
    addiu $t2, $t2, -0x4B
    addu $v0, $t1, $t2
    jr $zero
    
