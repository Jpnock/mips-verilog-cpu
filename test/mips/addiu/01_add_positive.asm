# Expect: 0xC

.text
.globl main
main:
    addiu $t0, $t0, 0x8     # t0 = 0x8
    addiu $t0, $t0, 0x3     # t0 = 0xB
    addiu $t0, $t0, 0x1     # t0 = 0xC
    addiu $v0, $t0, 0x0     # t0 = 0xC
    jr $zero

