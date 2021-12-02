# Expect: 0x19

.text
.globl main
main:
    addiu $v0, $v0, 0x5 
    addiu $t1, $t1, 0X5
    multu $v0, $t1
    jr $zero
