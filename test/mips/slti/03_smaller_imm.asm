# Expect: 0x00000000

.text
.globl main
main: 
    addiu $t0, $t0, 0x6999
    addiu $t1, $t1, 0x7659
    slti $v0, $t1, 0xFF88
    jr $zero
