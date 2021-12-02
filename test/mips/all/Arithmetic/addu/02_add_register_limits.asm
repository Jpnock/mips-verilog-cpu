# Expected: 0xFFFF

.text
.globl main
main:
    addiu $t1, $t1, 0xFFFF
    addu $v0, $v0, $v0
    addu $v0, $t1, $v0
    jr $zero
    