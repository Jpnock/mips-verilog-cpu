# Expect: -0x10000

.text
.globl main
main:
    addiu $t1, $t1, -0x8000 
    addiu $t2, $t2, -0x8000     
    addu $v0, $t1, $t2
    jr $zero
