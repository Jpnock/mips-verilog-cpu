# Expect: 0x14589bba

.text
.globl main
main:
    la $t0, var2
    lw $v0, -4($t0)
    jr $zero
.data
var: .word 0x14589BBA
var2: .word 0x468024CD
var3: .word 0x6969B420