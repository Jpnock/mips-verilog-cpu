# Expect: 0x0

.text
.globl main
main:
    and $v0, $t1, $t2
    and $v0, $t1, $v0
    jr $zero
