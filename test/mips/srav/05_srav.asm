# Expect: 0x61856AFC

.text
.globl main
main:
    la		$v0,  0x61856AFC
    la		$t0,  0x0
    srav    $v0, $v0, $t0
    jr      $zero	
