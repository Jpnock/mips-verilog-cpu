# Expect: 0xFFF60019

.text
.globl main
main:
    addiu $v0, $v0, 0xFFFB
    addiu $t1, $t1, 0xFFFB
    multu $v0, $t1
    jr $zero
