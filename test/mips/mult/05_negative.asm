# Expect: 0x19

.text
.globl main
main:
    addiu $v0, $v0, 0xFFFB
    addiu $t1, $t1, 0xFFFB
    mult $v0, $t1
    jr $zero
    