# Expect: 0xBFC00008

.text
.globl main
main:
    jal L1
L1: or $v0, $ra, $zero
    jr $zero

.data
    var1: .word 0x1
