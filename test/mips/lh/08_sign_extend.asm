# Expect: 0xFFFFF458

.text
.globl main
main:
    la $t0, var1
    lh $v0, 0($t0)
    jr $zero
.data
    var1: .word 0xF4589BBA
