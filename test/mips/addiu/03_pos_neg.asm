# Expect: -0x48

.text
.globl main
main:
    addiu $t0, $t0, -0x6A
    addiu $v0, $t0, 0x22
    jr $zero
