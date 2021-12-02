# Expect: 0xFFFE0001

.text
.globl main
main:
    addiu $v0, $v0, 0xFFFF
    addiu $t1, $t1, 0xFFFF
    multu $v0, $t1
    jr $zero
