# Expect: 0xffff8165

.text
.globl main
main:   
    addiu $v0, $v0, 0x8163
    addiu $t0, $t0, 0x8164
    beq $v0, $t0, L3
L1: addiu $v0, $v0, 1
L2: beq $v0, $t0, L1
L3: jr $zero
