# Expect: 0xA0000000

.text
.globl main
main:
    la		$v0, 0xAFFFFFFF
    la		$t0, 0x0FFFFFFF
    subu    $v0, $v0, $t0
    jr $zero

    