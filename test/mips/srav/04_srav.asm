# Expect: 0x0

.text
.globl main
main:
    lw		$v0,  0x115AFC10
    lw		$t0,  0x01100111
    srlv    $v0, $v0, $t0
    jr      $zero	
