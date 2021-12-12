# Expect: 0x0000F458

.text
.globl main
main:
    la $t0, var1
    lhu $v0, 0($t0)
    jr $zero
.data
    var1: .word 0xF4589BBA
