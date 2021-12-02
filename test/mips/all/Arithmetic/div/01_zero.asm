# Expected: 0x0

.text
.globl main
main:
    addiu $t1, $t1, 0x4
    div $v0, $t1
    jr $zero
