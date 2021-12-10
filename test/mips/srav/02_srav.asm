# Expect: 0xFFFFFFFF

.text
.globl main
main:
    la		$v0,  0xA8576AFD
    la		$t0,  31
    srav    $v0, $v0, $t0
    jr      $zero	
