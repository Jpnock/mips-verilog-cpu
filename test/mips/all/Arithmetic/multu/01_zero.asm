# Expected: 0x0

.text
.globl main
main:
    multu $v0, $v0
    jr $zero
    