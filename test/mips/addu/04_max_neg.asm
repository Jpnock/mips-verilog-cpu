# Expect: -0xFFFFFFFE

.text
.globl main
main:
    addiu $t0, $zero, -0x7FFF
    sll $t0, $t0, 0x10
    addu $t1, $t1, -0x7FFF
    addu $t1, $t1, $t1
    addiu $t0, $t0, -0x1
    addu $t0, $t1, $t0 
    
    addiu $t2, $t0, 0x0
     
    addu $v0, $t0, $t2
    jr $zero
