# Expect: 0x17FFD

.text
.globl main
main:
    addiu $t0, $zero, 0x7FFF
    addiu $t0, $t0, 0x7FFF
    addiu $t0, $t0, 0x7FFF
    sw $t0, var1
    lw $v0, var1
    jr $zero

.data
    var1: .word 0x00000000
