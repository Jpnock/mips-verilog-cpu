# Expect: 0xBA8024CD

.text
.globl main
main:
    lw $t0, var1
    sb $t0, var2
    lw $v0, var2
    jr $zero

.data
    var1: .word 0x14589BBA
    var2: .word 0x468024CD
