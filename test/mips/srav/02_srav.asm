# Expect: 0xFFFFFFFF

.text
.globl main
main:
    lw		$v0,  0xA8576AFD
    lw		$t0,  0x00011111
    srlv    $v0, $v0, $t0
    jr      $zero	
