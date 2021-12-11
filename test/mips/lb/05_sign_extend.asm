# Expect: 0xFFFFFF9B

.text
.globl main
main:
    la $t0, var1
    lb $v0, 2($t0)
    jr $zero
.data
    var1: .word 0x14589BBA
