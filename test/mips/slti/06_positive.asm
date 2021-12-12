# Expect: 0x1

.text
.globl main
main: 
    addiu $t1, $zero, 1
    slti $v0, $t1, 2
    jr $zero
