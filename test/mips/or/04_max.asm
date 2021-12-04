# Expect: 0x7FFF

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF
    addiu $t2, $t2, 0x7FFF
    or $v0, $t1, $t2
    jr $zero
