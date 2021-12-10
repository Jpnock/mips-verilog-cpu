# Expect: 0x00004680

.text
.globl main
main:
    lh $v0, var2
    jr $zero
.data
    var: .word 0x14589BBA
    var2: .word 0x468024CD
