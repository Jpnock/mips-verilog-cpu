# Expect: 0x0000009B

.text
.globl main
main:
    la $t0, var1
    lbu $v0, 2($t0)
    jr $zero
.data
    var1: .word 0x14589BBA
