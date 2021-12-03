# Expect: 0x00001458

.text
.globl main
main:
    lh $t0, var
    la $t1, var2
    sh $t0, 2($t1)
    lh $v0, 2($t1)
    jr $zero

.data
var: .word 0x14589BBA
var2: .word 0x468024CD