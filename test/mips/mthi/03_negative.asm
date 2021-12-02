# Expect: -5

.text
.globl main
main:
    addiu $v0, $v0, -5
    mthi $v0
    jr $zero
