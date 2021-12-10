# Expect: 0x358B

.text
.globl main
main:
    lw		$v0,  0x1AC5D3C7
    lw		$t0,  0x00001111
    srlv    $v0, $v0, $t0
    jr      $zero	
