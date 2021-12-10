# Expect: 0x8AD

.text
.globl main
main:
    la		$v0,  0x115AFC10
    la		$t0,  17826065
    srav    $v0, $v0, $t0
    jr      $zero	
