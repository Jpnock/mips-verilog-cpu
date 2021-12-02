# Expect: 0xFFFE

.text
.globl main
main:
    addiu $t1, $t1, 0x7FFF
    addiu $t2, $t2, 0x7FFF
    addu $v0, $t1, $t2 
    jr $zero
