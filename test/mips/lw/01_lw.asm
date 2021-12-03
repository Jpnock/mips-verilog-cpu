# Expect: 0x468024CD

.text
.globl main
main:
    lw $v0, var2
    jr $zero
.data
var: .word 0x14589BBA
var2: .word 0x468024CD