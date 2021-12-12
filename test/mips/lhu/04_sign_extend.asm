# Expect: 0x00009BBA

.text
.globl main
main:
    la $t0, var1
    lhu $v0, 2($t0)
    jr $zero
.data
    var1: .word 0x14589BBA
