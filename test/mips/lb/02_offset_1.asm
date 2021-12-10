# Expect: 0x01

.text
.globl main
main:
    addiu $t1, $zero, 0x7FFF
    addiu $t1, $t1, 0x7FFF
    addiu $t1, $t1, 0x7FFF
    sw $t1, var1
    la $t0, var1
    lb $v0, 1($t0)
    jr $zero

.data
    var1: .word 0x11111111
