# Expect: 0xC

.text
.globl main
main:
    addiu $v0, $v0, 0x8     # v0 = 0x8
    addiu $v0, $v0, 0x3     # v0 = 0xB
    addiu $v0, $v0, 0x1     # v0 = 0xC
    addiu $v0, $v0, 0x0     # v0 = 0xC
    jr $zero

