# Expect: 0x0

.text
.globl main
main:
    la		$v0,  0x115AFC10
    la		$t0,  0x01100111
    srav    $v0, $v0, $t0
    jr      $zero	
