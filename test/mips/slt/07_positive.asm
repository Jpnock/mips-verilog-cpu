# Expect: 0x0

.text
.globl main
main: 
    addiu $t1, $zero, 2
    addiu $t2, $zero, 3
    slt $v0, $t2, $t1
    jr $zero
