# Expect: 0x61856AFC

.text
.globl main
main:
    lw		$v0,  0x61856AFC
    lw		$t0,  0x0
    srlv    $v0, $v0, $t0
    jr      $zero	
