# Expect: 0x00000000

# Test: Ensures immediate is sign extended; rd = 0 only if immediate is sign extended.

.text
.globl main
main:
    lw $t0, var
    slti $v0, $t0, 0xFFFF
    jr $zero

.data
var: .word 0x00000FFF
