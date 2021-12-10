# Expect: 0x0

.text
.globl main
main:
    la		$v0,  0xAC146BCF
    la		$t0,  0x00111111
    srlv    $v0, $v0, $t0
    jr      $zero	
