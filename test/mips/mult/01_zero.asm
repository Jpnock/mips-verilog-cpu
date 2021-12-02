# Expect: 0x0

.text
.globl main
main:
    mult $v0, $v0
    jr $zero
    