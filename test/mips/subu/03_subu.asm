# Expect: 0xA0000000

.text
.globl main
main:
    lw		$v0, 0xAFFFFFFF
    lw		$t0, 0x0FFFFFFF
    subu    $v0, $v0, $t0

    