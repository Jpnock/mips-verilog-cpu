# Expected: 0xFFFB

.text
.globl main
main:
    addiu $v0, $v0, 0xFFFB
    mtlo $v0
    jr $zero
