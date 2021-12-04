# Expect: 0x14

.text
.globl main
main:
    addiu $t1, $t1, 0x1F
    andi $v0, $t1, 0x14
    jr $zero
