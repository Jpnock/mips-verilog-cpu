# Expect: 0x00000000

# Test: Ensures rd = 0 when rs = imm; imm is assumed to be sign extended.

.text
.globl main
main:
    addiu $t0, $t0, 0x9999
    addiu $t1, $t1, 0xFFFF
    slti $v0, $t1, 0xFFFF
    jr $zero
