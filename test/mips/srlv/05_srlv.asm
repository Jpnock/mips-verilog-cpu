# Expect: 0x1

.text
.globl main
main:
    la		$v0,  0xD47A11F1
    la		$t0,  0x00011111
    srlv    $v0, $v0, $t0
    jr      $zero	
    