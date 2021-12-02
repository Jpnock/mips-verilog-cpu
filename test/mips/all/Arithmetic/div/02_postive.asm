# Expected: 0x3

.text
.globl main
main:
    addiu $t1, $t1, 0xF
    addiu $t2, $t2, 0x5
    div $t1, $t2
    jr $zero


