# Expect: 0xFFFE

.text
.globl main
main:
    addiu $t0, $t0, 0x7FFF  # t0 = 0x7FFF
    addiu $v0, $t0, 0x7FFF  # t0 = 0xFFFE
    jr $zero
