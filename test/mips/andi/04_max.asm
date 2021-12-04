# Expect: 0x7FFF

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF
    andi $v0, $t1, 0x7FFF
    jr $zero
    