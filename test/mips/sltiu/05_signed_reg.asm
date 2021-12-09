# Expect: 0x00000000


# weird edge case where register is signextended from the least signification 16 bits
# of a register.
.text
.globl main
main: 
    lw $t0, var1
    sltiu $v0, $t0, 0x0000 
    jr $zero

.data
var1: .word 0x0000FFFF 


