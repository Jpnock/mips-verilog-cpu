# Expect: 0x00000000

# Test: Ensures register contents are not sign extended.

.text
.globl main
main: 
    lw $t0, var
    slti $v0, $t0, 0xFFFF
    jr $zero

.data
var: .word 0x0000FFFE
