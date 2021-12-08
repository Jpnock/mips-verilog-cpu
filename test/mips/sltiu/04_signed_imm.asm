# Expect: 0x00000001

.text
.globl main
main: 
    lw $t0, var1
    sltiu $v0, $t0, 0xFFFF # immediate is sign extended, thus larger
    jr $zero

.data
var1: .word 0x0001FFFF


