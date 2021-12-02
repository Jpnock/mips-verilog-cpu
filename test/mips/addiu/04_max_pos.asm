# Expect: 0xFFFE

.text
.globl main
main:
    addiu $v0, $v0, 0x7FFF  # v0 = 0x7FFF
    addiu $v0, $v0, 0x7FFF  # v0 = 0xFFFE
    jr $zero
