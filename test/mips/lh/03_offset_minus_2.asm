# Expect: 0xffff9bba

.text
.globl main
main:
    la $t0, var2
    lh $v0, -2($t0)
    jr $zero
.data
    var: .word 0x14589BBA
    var2: .word 0x468024CD
