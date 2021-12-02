# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF
    xori $v0, $t1, 0x7FFF
    jr $zero
