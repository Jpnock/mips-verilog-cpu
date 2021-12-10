# Expect: 0x0000009b

.text
.globl main
main:
    la $t0, var2
    lbu $v0, -2($t0)
    jr $zero
.data
    var: .word 0x14589BBA
    var2: .word 0x468024CD
