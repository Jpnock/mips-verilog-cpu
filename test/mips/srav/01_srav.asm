# Expect: 0xFFFECABD

.text
.globl main
main:
    la		$v0,  0xD957AC1F
    la		$t0,  0x00001101
    srav    $v0, $v0, $t0
    jr      $zero	
