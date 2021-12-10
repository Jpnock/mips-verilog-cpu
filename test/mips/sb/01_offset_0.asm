# Expect: 0x00000014

.text
.globl main
main:
    lb $t0, var
    la $t1, var2
    sb $t0, 0($t1)
    lb $v0, 0($t1)
    jr $zero

.data
    var: .word 0x14589BBA
    var2: .word 0x468024CD
