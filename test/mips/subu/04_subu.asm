# Expect: 0xFFFFFFFF

.text
.globl main
main:
    lw		$v0, 0xF0000000
    lw		$t0, -0x0FFFFFFF
    subu    $v0, $v0, $t0
