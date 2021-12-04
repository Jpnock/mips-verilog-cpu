# Expect: 0x0

.text
.globl main
main:
    addiu $t2, $t2, 0x7
    and $v0, $t1, $t2   
    jr $zero 
