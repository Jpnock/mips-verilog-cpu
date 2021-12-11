# Expect: 0xF8414243

.text
.globl main
main:
    lw $v0, var1
    jr $zero
.data
    var1: .word 0xF8414243
