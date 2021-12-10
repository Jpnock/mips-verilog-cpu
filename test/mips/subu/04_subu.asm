# Expect: 0xFFFFFFFF

.text
.globl main
main:
    la		$v0, 0xF0000000
    la		$t0, -0x0FFFFFFF
    subu    $v0, $v0, $t0
    jr      $zero