# Expect: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0xFFFF
    andi $v0, $t1, 0X0
    jr $zero
    