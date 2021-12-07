# Expect: 0x000024cd

.text
.globl main
main:
    la $t0, var2
    lhu $v0, 2($t0)
    jr $zero
.data
var: .word 0x14589BBA
var2: .word 0x468024CD