# Expect: 0x00000000

.text
.globl main
main: 
    addiu $t0, $t0, 0x0009
    sltiu $v0, $t0, 0x0006
    jr $zero


