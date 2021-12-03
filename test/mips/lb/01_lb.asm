# Expect: 0x00000014

.text
.globl main
main:
    lb $v0, var
    jr $zero
.data
var: .word 0x14589BBA
var2: .word 0x468024CD