# Expect: 0x333566E

.text
.globl main
main:
    lw		$v0,  0x666ACDC1
    lw		$t0,  0x00000101
    srlv    $v0, $v0, $t0
    jr      $zero	
