# Expect: 0x0

.text
.globl main
main:
    lw		$v0,  0xAC146BCF
    lw		$t0,  0x00111111
    srlv    $v0, $v0, $t0
    jr      $zero	
