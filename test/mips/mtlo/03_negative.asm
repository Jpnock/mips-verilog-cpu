# Expect: -170

.text
.globl main
main:
    addiu $v0, $v0, -170
    mtlo $v0
    jr $zero
