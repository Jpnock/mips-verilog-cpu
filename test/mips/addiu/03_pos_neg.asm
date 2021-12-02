# Expect: -0x48

.text
.globl main
main:
    addiu $v0, $v0, -0x6A
    addiu $v0, $v0, 0x22
    jr $zero
