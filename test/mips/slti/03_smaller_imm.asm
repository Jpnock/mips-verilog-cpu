# Expect: 0x00000000

# Test: Ensures rt = 0 when $signed(rs) > $signed(imm); imm is assumed to be sign extended.

.text
.globl main
main: 
    addiu $t0, $t0, 0x6999
    addiu $t1, $t1, 0x7659
    slti $v0, $t1, 0xFF88
    jr $zero
