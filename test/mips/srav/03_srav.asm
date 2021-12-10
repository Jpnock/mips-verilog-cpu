# Expect: 0x358B

.text
.globl main
main:
    la		$v0,  0x1AC5D3C7
    la		$t0,  0x00001111
    srav    $v0, $v0, $t0
    jr      $zero	
